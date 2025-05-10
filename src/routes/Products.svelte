<script lang="ts">
  import { onMount } from 'svelte';
  import ProductCard from '../components/ProductCard.svelte';
  import { supabase } from '../lib/supabase';
  
  // Product categories
  const categories = [
    { id: 'all', name: 'All Products' },
    { id: 'Spices', name: 'Spices & Seasonings' },
    { id: 'Pantry', name: 'Pantry Items' },
    { id: 'Dairy', name: 'Dairy Products' },
    { id: 'Bread', name: 'Breads' },
    { id: 'Meat', name: 'Meats' },
    { id: 'Sweets', name: 'Sweets & Pastries' },
    { id: 'Dry Goods', name: 'Dry Goods' },
    { id: 'Beverages', name: 'Beverages' }
  ];
  
  let activeCategory = 'all';
  let searchQuery = '';
  let products = [];
  let filteredProducts = [];
  let loading = true;
  let error = null;
  
  async function fetchProducts() {
    try {
      loading = true;
      let query = supabase
        .from('products')
        .select('*')
        .is('deleted_at', null);
        
      if (activeCategory !== 'all') {
        query = query.eq('category', activeCategory);
      }
      
      if (searchQuery) {
        query = query.or(`name.ilike.%${searchQuery}%,description.ilike.%${searchQuery}%`);
      }
      
      const { data, error: fetchError } = await query;
        
      if (fetchError) throw fetchError;
      
      filteredProducts = data;
    } catch (err) {
      error = err.message;
    } finally {
      loading = false;
    }
  }
  
  function setCategory(categoryId: string) {
    activeCategory = categoryId;
    fetchProducts();
  }
  
  function handleSearch() {
    fetchProducts();
  }
  
  onMount(() => {
    fetchProducts();
  });
</script>

<div class="bg-neutral-50 py-12 min-h-screen">
  <!-- Page Header -->
  <div class="bg-primary-600 py-12 mb-8">
    <div class="container mx-auto px-4">
      <h1 class="text-3xl font-bold text-white mb-2">Our Products</h1>
      <p class="text-primary-100 max-w-2xl">Browse our selection of authentic Middle Eastern products, from fresh bakery items to premium meats and essential Arab groceries.</p>
    </div>
  </div>
  
  <div class="container mx-auto px-4">
    <!-- Search and Filter -->
    <div class="bg-white p-6 rounded-lg shadow-md mb-8">
      <div class="flex flex-col md:flex-row justify-between items-center gap-4">
        <!-- Category Filters -->
        <div class="flex flex-wrap gap-2">
          {#each categories as category}
            <button 
              class={`px-4 py-2 rounded-full text-sm font-medium transition-colors ${activeCategory === category.id ? 'bg-primary-500 text-white' : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'}`}
              on:click={() => setCategory(category.id)}
            >
              {category.name}
            </button>
          {/each}
        </div>
        
        <!-- Search Bar -->
        <div class="w-full md:w-auto">
          <div class="relative">
            <input 
              type="text" 
              placeholder="Search products..." 
              class="w-full pl-10 pr-4 py-2 rounded-lg border border-neutral-300 focus:outline-none focus:ring-2 focus:ring-primary-500"
              bind:value={searchQuery}
              on:input={handleSearch}
            />
            <svg class="absolute left-3 top-2.5 h-5 w-5 text-neutral-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Products Grid -->
    {#if loading}
      <div class="flex justify-center items-center h-64">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-500"></div>
      </div>
    {:else if error}
      <div class="bg-red-50 text-red-600 p-4 rounded-lg">
        {error}
      </div>
    {:else}
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        {#if filteredProducts.length > 0}
          {#each filteredProducts as product}
            <ProductCard {product} />
          {/each}
        {:else}
          <div class="col-span-full py-16 text-center">
            <p class="text-xl text-neutral-500">No products found matching your criteria.</p>
            <button 
              class="mt-4 btn btn-primary"
              on:click={() => {
                activeCategory = 'all';
                searchQuery = '';
                fetchProducts();
              }}
            >
              Clear Filters
            </button>
          </div>
        {/if}
      </div>
    {/if}
  </div>
</div>