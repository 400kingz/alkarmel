<script lang="ts">
  import { cart, type CartItem } from '../lib/cart';
  import { navigate } from 'svelte-routing';
  
  let isLoading = false;
  let error = '';
  
  function checkout() {
    navigate('/checkout');
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
          <div class="flex items-center">
            <img 
              src={item.image} 
              alt={item.name} 
              class="w-16 h-16 object-cover rounded-lg mr-4"
            />
            <div>
              <h3 class="font-medium">{item.name}</h3>
              <p class="text-neutral-600">${item.price.toFixed(2)}</p>
            </div>
          </div>
          <div class="flex items-center space-x-4">
            <div class="flex items-center space-x-2">
              <button 
                class="text-neutral-600 hover:text-primary-600 w-8 h-8 flex items-center justify-center rounded-full bg-neutral-100"
                on:click={() => updateQuantity(item, item.quantity - 1)}
              >
                -
              </button>
              <span class="w-8 text-center">{item.quantity}</span>
              <button 
                class="text-neutral-600 hover:text-primary-600 w-8 h-8 flex items-center justify-center rounded-full bg-neutral-100"
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