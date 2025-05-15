import { supabase } from './supabase';
import type { CartItem } from './cart';

export interface ShippingAddress {
  firstName: string;
  lastName: string;
  address1: string;
  address2?: string;
  city: string;
  state: string;
  postalCode: string;
  country: string;
  phone: string;
  email: string;
}

export interface CheckoutData {
  items: CartItem[];
  shippingAddress: ShippingAddress;
  billingAddress?: ShippingAddress;
  useSameAddress: boolean;
  email: string;
  phone: string;
}

export async function createCheckoutSession(checkoutData: CheckoutData) {
  try {
    const { data: { session_url }, error: checkoutError } = await supabase.functions.invoke('stripe-checkout', {
      body: {
        items: checkoutData.items.map(item => ({
          price: item.stripePriceId,
          quantity: item.quantity
        })),
        shipping_address: checkoutData.shippingAddress,
        billing_address: checkoutData.useSameAddress ? checkoutData.shippingAddress : checkoutData.billingAddress,
        email: checkoutData.email,
        phone: checkoutData.phone
      }
    });

    if (checkoutError) throw checkoutError;
    return session_url;
  } catch (err) {
    throw new Error(err instanceof Error ? err.message : 'Checkout failed');
  }
}