<script lang="ts">
  import { cart } from '../lib/cart';
  import { createCheckoutSession, type ShippingAddress } from '../lib/checkout';
  
  let isLoading = false;
  let error = '';
  let useSameAddress = true;

  let shippingAddress: ShippingAddress = {
    firstName: '',
    lastName: '',
    address1: '',
    address2: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    phone: '',
    email: ''
  };

  let billingAddress: ShippingAddress = { ...shippingAddress };

  async function handleSubmit() {
    try {
      isLoading = true;
      error = '';

      const checkoutUrl = await createCheckoutSession({
        items: $cart,
        shippingAddress,
        billingAddress: useSameAddress ? undefined : billingAddress,
        useSameAddress,
        email: shippingAddress.email,
        phone: shippingAddress.phone
      });

      window.location.href = checkoutUrl;
    } catch (err) {
      error = err instanceof Error ? err.message : 'An error occurred';
    } finally {
      isLoading = false;
    }
  }
</script>

<form on:submit|preventDefault={handleSubmit} class="space-y-8">
  <div>
    <h2 class="text-2xl font-bold mb-6">Shipping Information</h2>
    
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div>
        <label for="firstName" class="block text-sm font-medium text-neutral-700">First Name</label>
        <input
          type="text"
          id="firstName"
          bind:value={shippingAddress.firstName}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div>
        <label for="lastName" class="block text-sm font-medium text-neutral-700">Last Name</label>
        <input
          type="text"
          id="lastName"
          bind:value={shippingAddress.lastName}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div class="col-span-2">
        <label for="email" class="block text-sm font-medium text-neutral-700">Email</label>
        <input
          type="email"
          id="email"
          bind:value={shippingAddress.email}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div class="col-span-2">
        <label for="phone" class="block text-sm font-medium text-neutral-700">Phone</label>
        <input
          type="tel"
          id="phone"
          bind:value={shippingAddress.phone}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div class="col-span-2">
        <label for="address1" class="block text-sm font-medium text-neutral-700">Address Line 1</label>
        <input
          type="text"
          id="address1"
          bind:value={shippingAddress.address1}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div class="col-span-2">
        <label for="address2" class="block text-sm font-medium text-neutral-700">Address Line 2</label>
        <input
          type="text"
          id="address2"
          bind:value={shippingAddress.address2}
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div>
        <label for="city" class="block text-sm font-medium text-neutral-700">City</label>
        <input
          type="text"
          id="city"
          bind:value={shippingAddress.city}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div>
        <label for="state" class="block text-sm font-medium text-neutral-700">State</label>
        <input
          type="text"
          id="state"
          bind:value={shippingAddress.state}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div>
        <label for="postalCode" class="block text-sm font-medium text-neutral-700">Postal Code</label>
        <input
          type="text"
          id="postalCode"
          bind:value={shippingAddress.postalCode}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        />
      </div>
      
      <div>
        <label for="country" class="block text-sm font-medium text-neutral-700">Country</label>
        <select
          id="country"
          bind:value={shippingAddress.country}
          required
          class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
        >
          <option value="">Select a country</option>
          <option value="US">United States</option>
          <option value="CA">Canada</option>
        </select>
      </div>
    </div>
  </div>

  <div>
    <div class="flex items-center mb-6">
      <input
        type="checkbox"
        id="useSameAddress"
        bind:checked={useSameAddress}
        class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-neutral-300 rounded"
      />
      <label for="useSameAddress" class="ml-2 block text-sm text-neutral-900">
        Billing address same as shipping
      </label>
    </div>

    {#if !useSameAddress}
      <h2 class="text-2xl font-bold mb-6">Billing Information</h2>
      
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Same fields as shipping address but for billing -->
        <div>
          <label for="billingFirstName" class="block text-sm font-medium text-neutral-700">First Name</label>
          <input
            type="text"
            id="billingFirstName"
            bind:value={billingAddress.firstName}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div>
          <label for="billingLastName" class="block text-sm font-medium text-neutral-700">Last Name</label>
          <input
            type="text"
            id="billingLastName"
            bind:value={billingAddress.lastName}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div class="col-span-2">
          <label for="billingAddress1" class="block text-sm font-medium text-neutral-700">Address Line 1</label>
          <input
            type="text"
            id="billingAddress1"
            bind:value={billingAddress.address1}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div class="col-span-2">
          <label for="billingAddress2" class="block text-sm font-medium text-neutral-700">Address Line 2</label>
          <input
            type="text"
            id="billingAddress2"
            bind:value={billingAddress.address2}
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div>
          <label for="billingCity" class="block text-sm font-medium text-neutral-700">City</label>
          <input
            type="text"
            id="billingCity"
            bind:value={billingAddress.city}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div>
          <label for="billingState" class="block text-sm font-medium text-neutral-700">State</label>
          <input
            type="text"
            id="billingState"
            bind:value={billingAddress.state}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div>
          <label for="billingPostalCode" class="block text-sm font-medium text-neutral-700">Postal Code</label>
          <input
            type="text"
            id="billingPostalCode"
            bind:value={billingAddress.postalCode}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          />
        </div>
        
        <div>
          <label for="billingCountry" class="block text-sm font-medium text-neutral-700">Country</label>
          <select
            id="billingCountry"
            bind:value={billingAddress.country}
            required
            class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
          >
            <option value="">Select a country</option>
            <option value="US">United States</option>
            <option value="CA">Canada</option>
          </select>
        </div>
      </div>
    {/if}
  </div>

  {#if error}
    <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-md">
      {error}
    </div>
  {/if}

  <div class="flex justify-end">
    <button
      type="submit"
      class="btn btn-primary"
      disabled={isLoading}
    >
      {#if isLoading}
        <span class="flex items-center">
          <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
          Processing...
        </span>
      {:else}
        Continue to Payment
      {/if}
    </button>
  </div>
</form>