<script lang="ts">
  import { cart, type CartItem } from '../lib/cart';
  import { stripe } from '../lib/stripe';
  
  let isLoading = false;
  let error = '';
  
  async function checkout() {
    try {
      isLoading = true;
      error = '';
      
      const response = await fetch('/api/create-checkout-session', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          items: $cart.map(item => ({
            price: item.stripePriceId,
            quantity: item.quantity
          }))
        })
      });
      
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      
      const { sessionId } = await response.json();
      
      // Redirect to Stripe Checkout
      const result = await stripe?.redirectToCheckout({
        sessionId
      });
      
      if (result?.error) {
        throw new Error(result.error.message);
      }
    } catch (err) {
      error = err instanceof Error ? err.message : 'An error occurred';
    } finally {
      isLoading = false;
    }
  }
  
  function updateQuantity(item: CartItem, newQuantity: number) {
    if (newQuantity < 1) {
      cart.removeItem(item.id);
    } else {
      cart.updateQuantity(item.id, newQuantity);
    }
  }
</script>

<div class="bg-white rounded-lg shadow-lg p-6">
  <h2 class="text-2xl font-bold mb-6">Shopping Cart</h2>
  
  {#if $cart.length === 0}
    <p class="text-neutral-600">Your cart is empty</p>
  {:else}
    <div class="space-y-4">
      {#each $cart as item}
        <div class="flex items-center justify-between border-b pb-4">
          <div>
            <h3 class="font-medium">{item.name}</h3>
            <p class="text-neutral-600">${item.price.toFixed(2)}</p>
          </div>
          <div class="flex items-center space-x-4">
            <div class="flex items-center space-x-2">
              <button 
                class="text-neutral-600 hover:text-primary-600"
                on:click={() => updateQuantity(item, item.quantity - 1)}
              >
                -
              </button>
              <span>{item.quantity}</span>
              <button 
                class="text-neutral-600 hover:text-primary-600"
                on:click={() => updateQuantity(item, item.quantity + 1)}
              >
                +
              </button>
            </div>
            <button 
              class="text-red-500 hover:text-red-600"
              on:click={() => cart.removeItem(item.id)}
            >
              Remove
            </button>
          </div>
        </div>
      {/each}
      
      <div class="pt-4">
        <div class="flex justify-between font-bold text-lg">
          <span>Total:</span>
          <span>${cart.getTotal().toFixed(2)}</span>
        </div>
        
        {#if error}
          <p class="text-red-500 mt-4">{error}</p>
        {/if}
        
        <button 
          class="btn btn-primary w-full mt-6"
          on:click={checkout}
          disabled={isLoading}
        >
          {#if isLoading}
            Processing...
          {:else}
            Checkout
          {/if}
        </button>
      </div>
    </div>
  {/if}
</div>