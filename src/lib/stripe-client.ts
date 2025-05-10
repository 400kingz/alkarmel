import { supabase } from './supabase';
import { products, type ProductId } from '../stripe-config';

export async function createCheckoutSession(productId: ProductId) {
  const product = products[productId];
  
  if (!product) {
    throw new Error('Invalid product ID');
  }

  const { data: { session_url }, error } = await supabase.functions.invoke('stripe-checkout', {
    body: {
      price_id: product.priceId,
      mode: product.mode,
      success_url: `${window.location.origin}/success`,
      cancel_url: `${window.location.origin}/cart`,
    },
  });

  if (error) {
    throw new Error(error.message);
  }

  return session_url;
}