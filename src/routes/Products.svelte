<script lang="ts">
  import { onMount } from 'svelte';
  import ProductCard from '../components/ProductCard.svelte';
  
  // Product categories
  const categories = [
    { id: 'all', name: 'All Products' },
    { id: 'bakery', name: 'Bakery' },
    { id: 'meat', name: 'Meat' },
    { id: 'essentials', name: 'Arab Essentials' },
    { id: 'oils', name: 'Olive Oils' },
    { id: 'spices', name: 'Spices & Herbs' }
  ];
  
  // Sample products data
  const allProducts = [
    {
      id: 1,
      name: "Fresh Pita Bread",
      category: "bakery",
      image: "https://images.pexels.com/photos/461060/pexels-photo-461060.jpeg",
      description: "Freshly baked traditional pita bread, perfect for dipping in hummus or making wraps.",
      price: 3.99
    },
    {
      id: 2,
      name: "Za'atar Manakeesh",
      category: "bakery",
      image: "https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg",
      description: "Traditional flatbread topped with olive oil and za'atar spice blend.",
      price: 4.99
    },
    {
      id: 3,
      name: "Sesame Kaak",
      category: "bakery",
      image: "https://images.pexels.com/photos/2067396/pexels-photo-2067396.jpeg",
      description: "Crunchy sesame bread rings, a popular Middle Eastern snack.",
      price: 5.99
    },
    {
      id: 4,
      name: "Premium Lamb Cuts",
      category: "meat",
      image: "https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg",
      description: "High-quality lamb cuts, perfect for traditional Middle Eastern dishes.",
      price: 15.99
    },
    {
      id: 5,
      name: "Beef Kebab Meat",
      category: "meat",
      image: "https://images.pexels.com/photos/6941026/pexels-photo-6941026.jpeg",
      description: "Premium ground beef seasoned for perfect kebabs every time.",
      price: 12.99
    },
    {
      id: 6,
      name: "Chicken Shawarma Meat",
      category: "meat",
      image: "https://images.pexels.com/photos/6941028/pexels-photo-6941028.jpeg",
      description: "Marinated chicken slices ready for your shawarma sandwiches.",
      price: 10.99
    },
    {
      id: 7,
      name: "Palestinian Olive Oil",
      category: "oils",
      image: "https://images.pexels.com/photos/33783/olive-oil-salad-dressing-cooking-olive.jpg",
      description: "Authentic extra virgin olive oil imported directly from Palestinian olive groves.",
      price: 19.99
    },
    {
      id: 8,
      name: "Premium Tahini",
      category: "essentials",
      image: "https://images.pexels.com/photos/7474327/pexels-photo-7474327.jpeg",
      description: "Rich and creamy tahini paste made from 100% sesame seeds.",
      price: 7.99
    },
    {
      id: 9,
      name: "Authentic Hummus",
      category: "essentials",
      image: "https://images.pexels.com/photos/1618898/pexels-photo-1618898.jpeg",
      description: "Creamy chickpea dip made with traditional ingredients.",
      price: 5.99
    },
    {
      id: 10,
      name: "Za'atar Spice Blend",
      category: "spices",
      image: "https://images.pexels.com/photos/4198943/pexels-photo-4198943.jpeg",
      description: "Traditional Middle Eastern spice blend with thyme, sesame, and sumac.",
      price: 6.99
    },
    {
      id: 11,
      name: "Organic Sumac",
      category: "spices",
      image: "https://images.pexels.com/photos/4226805/pexels-photo-4226805.jpeg",
      description: "Tangy spice made from ground sumac berries, essential in Middle Eastern cuisine.",
      price: 8.99
    },
    {
      id: 12,
      name: "Turkish Coffee",
      category: "essentials",
      image: "https://images.pexels.com/photos/894695/pexels-photo-894695.jpeg",
      description: "Finely ground coffee for preparing traditional Turkish coffee.",
      price: 9.99
    }
  ];
  
  let activeCategory = 'all';
  let filteredProducts = [...allProducts];
  let searchQuery = '';
  
  // Filter products by category and search query
  function filterProducts() {
    if (activeCategory === 'all' && !searchQuery) {
      filteredProducts = [...allProducts];
      return;
    }
    
    filteredProducts = allProducts.filter(product => {
      const matchesCategory = activeCategory === 'all' || product.category === activeCategory;
      const matchesSearch = !searchQuery || 
        product.name.toLowerCase().includes(searchQuery.toLowerCase()) || 
        product.description.toLowerCase().includes(searchQuery.toLowerCase());
      
      return matchesCategory && matchesSearch;
    });
  }
  
  function setCategory(categoryId: string) {
    activeCategory = categoryId;
    filterProducts();
  }
  
  function handleSearch() {
    filterProducts();
  }
  
  onMount(() => {
    filterProducts();
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
              filterProducts();
            }}
          >
            Clear Filters
          </button>
        </div>
      {/if}
    </div>
  </div>
</div>