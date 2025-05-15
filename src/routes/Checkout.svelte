<script lang="ts">
  import { cart } from '../lib/cart';
  import { navigate } from 'svelte-routing';
  import CheckoutForm from '../components/CheckoutForm.svelte';
  import { onMount } from 'svelte';

  onMount(() => {
    if ($cart.length === 0) {
      navigate('/products');
    }
  });
</script>

<div class="min-h-screen bg-neutral-50 py-12">
  <div class="container mx-auto px-4">
    <div class="max-w-4xl mx-auto">
      <div class="bg-white rounded-lg shadow-md p-8">
        <h1 class="text-3xl font-bold mb-8">Checkout</h1>
        
        <div class="mb-8">
          <h2 class="text-xl font-bold mb-4">Order Summary</h2>
          <div class="space-y-4">
            {#each $cart as item}
              <div class="flex items-center justify-between border-b pb-4">
                <div class="flex items-center">
                  <img 
                    src={item.image} 
                    alt={item.name} 
                    class="w-16 h-16 object-cover rounded-lg mr-4"
                  />
                  <div>
                    <h3 class="font-medium">{item.name}</h3>
                    <p class="text-neutral-600">Quantity: {item.quantity}</p>
                  </div>
                </div>
                <p class="font-medium">${(item.price * item.quantity).toFixed(2)}</p>
              </div>
            {/each}
            
            <div class="flex justify-between pt-4 font-bold">
              <span>Total:</span>
              <span>${cart.getTotal().toFixed(2)}</span>
            </div>
          </div>
        </div>
        
        <CheckoutForm />
      </div>
    </div>
  </div>
</div>