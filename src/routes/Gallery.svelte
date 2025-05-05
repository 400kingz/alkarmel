<script lang="ts">
  import { onMount } from 'svelte';
  
  // Gallery images
  const galleryImages = [
    {
      src: "https://images.pexels.com/photos/461060/pexels-photo-461060.jpeg",
      alt: "Freshly baked bread",
      category: "bakery",
      title: "Traditional Pita Bread"
    },
    {
      src: "https://images.pexels.com/photos/4198943/pexels-photo-4198943.jpeg",
      alt: "Variety of spices",
      category: "spices",
      title: "Authentic Spice Selection"
    },
    {
      src: "https://images.pexels.com/photos/33783/olive-oil-salad-dressing-cooking-olive.jpg",
      alt: "Olive oil",
      category: "essentials",
      title: "Premium Olive Oil"
    },
    {
      src: "https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg",
      alt: "Fresh meat",
      category: "meat",
      title: "Quality Meat Cuts"
    },
    {
      src: "https://images.pexels.com/photos/2233729/pexels-photo-2233729.jpeg",
      alt: "Store front",
      category: "store",
      title: "Our Welcoming Store"
    },
    {
      src: "https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg",
      alt: "Za'atar bread",
      category: "bakery",
      title: "Za'atar Manakeesh"
    },
    {
      src: "https://images.pexels.com/photos/1618898/pexels-photo-1618898.jpeg",
      alt: "Hummus",
      category: "essentials",
      title: "Fresh Hummus"
    },
    {
      src: "https://images.pexels.com/photos/894695/pexels-photo-894695.jpeg",
      alt: "Arabic coffee",
      category: "essentials",
      title: "Traditional Coffee"
    },
    {
      src: "https://images.pexels.com/photos/2067396/pexels-photo-2067396.jpeg",
      alt: "Freshly baked bread",
      category: "bakery",
      title: "Artisan Bread"
    },
    {
      src: "https://images.pexels.com/photos/4198943/pexels-photo-4198943.jpeg",
      alt: "Spices in bowls",
      category: "spices",
      title: "Colorful Spice Display"
    },
    {
      src: "https://images.pexels.com/photos/6941026/pexels-photo-6941026.jpeg",
      alt: "Shawarma",
      category: "meat",
      title: "Shawarma Preparation"
    },
    {
      src: "https://images.pexels.com/photos/3814446/pexels-photo-3814446.jpeg",
      alt: "Baker",
      category: "store",
      title: "Our Expert Staff"
    }
  ];
  
  // Gallery categories
  const categories = [
    { id: 'all', name: 'All' },
    { id: 'bakery', name: 'Bakery' },
    { id: 'meat', name: 'Meat' },
    { id: 'essentials', name: 'Essentials' },
    { id: 'spices', name: 'Spices' },
    { id: 'store', name: 'Our Store' }
  ];
  
  let activeCategory = 'all';
  let filteredImages = [...galleryImages];
  let selectedImage = null;
  let lightboxOpen = false;
  
  // Filter images by category
  function filterImages(categoryId: string) {
    activeCategory = categoryId;
    
    if (categoryId === 'all') {
      filteredImages = [...galleryImages];
    } else {
      filteredImages = galleryImages.filter(img => img.category === categoryId);
    }
  }
  
  // Open lightbox
  function openLightbox(image: any) {
    selectedImage = image;
    lightboxOpen = true;
    document.body.style.overflow = 'hidden'; // Prevent scrolling
  }
  
  // Close lightbox
  function closeLightbox() {
    lightboxOpen = false;
    document.body.style.overflow = 'auto'; // Re-enable scrolling
  }
  
  // Handle keydown events for lightbox navigation
  function handleKeydown(event: KeyboardEvent) {
    if (!lightboxOpen) return;
    
    if (event.key === 'Escape') {
      closeLightbox();
    } else if (event.key === 'ArrowRight') {
      navigateImage(1);
    } else if (event.key === 'ArrowLeft') {
      navigateImage(-1);
    }
  }
  
  // Navigate to the next or previous image
  function navigateImage(direction: number) {
    if (!selectedImage) return;
    
    const currentIndex = filteredImages.findIndex(img => img.src === selectedImage.src);
    let newIndex = currentIndex + direction;
    
    if (newIndex < 0) {
      newIndex = filteredImages.length - 1;
    } else if (newIndex >= filteredImages.length) {
      newIndex = 0;
    }
    
    selectedImage = filteredImages[newIndex];
  }
  
  onMount(() => {
    // Add keyboard event listener
    window.addEventListener('keydown', handleKeydown);
    
    return () => {
      // Remove keyboard event listener on component destroy
      window.removeEventListener('keydown', handleKeydown);
    };
  });
</script>

<svelte:head>
  <title>Gallery - Al Karmel Meat & Bakery</title>
</svelte:head>

<div class="bg-neutral-50 min-h-screen">
  <!-- Hero Section -->
  <section class="relative bg-neutral-900 text-white">
    <div class="relative h-80">
      <img 
        src="https://images.pexels.com/photos/2233729/pexels-photo-2233729.jpeg" 
        alt="Gallery Banner" 
        class="absolute inset-0 w-full h-full object-cover opacity-40"
      />
      <div class="absolute inset-0 bg-gradient-to-r from-neutral-900 to-neutral-900/70"></div>
      <div class="container mx-auto px-4 relative h-full flex items-center">
        <div>
          <h1 class="text-4xl md:text-5xl font-bold mb-4">Gallery</h1>
          <p class="text-xl max-w-2xl text-neutral-200">Explore our visual collection of Middle Eastern delights, from fresh bakery items to premium meats and more.</p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Gallery Section -->
  <section class="py-16">
    <div class="container mx-auto px-4">
      <!-- Category Filters -->
      <div class="flex flex-wrap justify-center gap-3 mb-12">
        {#each categories as category}
          <button 
            class={`px-5 py-2 rounded-full text-sm font-medium transition-colors ${activeCategory === category.id ? 'bg-primary-500 text-white' : 'bg-white text-neutral-700 hover:bg-neutral-100'}`}
            on:click={() => filterImages(category.id)}
          >
            {category.name}
          </button>
        {/each}
      </div>
      
      <!-- Gallery Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {#each filteredImages as image, i}
          <!-- svelte-ignore a11y-click-events-have-key-events -->
          <div 
            class="relative overflow-hidden rounded-lg shadow-md cursor-pointer group transition-transform duration-300 hover:-translate-y-1"
            on:click={() => openLightbox(image)}
          >
            <img 
              src={image.src} 
              alt={image.alt} 
              class="w-full h-64 object-cover transition-transform duration-500 group-hover:scale-110"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-neutral-900 to-transparent opacity-0 group-hover:opacity-80 transition-opacity duration-300"></div>
            <div class="absolute bottom-0 left-0 p-4 text-white transform translate-y-4 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-300">
              <h3 class="font-bold">{image.title}</h3>
              <p class="text-sm text-neutral-200">{categories.find(cat => cat.id === image.category)?.name}</p>
            </div>
          </div>
        {/each}
      </div>
    </div>
  </section>
  
  <!-- Lightbox -->
  {#if lightboxOpen && selectedImage}
    <div 
      class="fixed inset-0 bg-neutral-900/90 z-50 flex items-center justify-center p-4"
      on:click={closeLightbox}
    >
      <div 
        class="relative max-w-5xl w-full"
        on:click|stopPropagation={() => {}}
      >
        <!-- Close Button -->
        <button 
          class="absolute top-4 right-4 text-white bg-neutral-800/50 rounded-full p-2 hover:bg-neutral-700/50 transition-colors z-10"
          on:click={closeLightbox}
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
        
        <!-- Previous Button -->
        <button 
          class="absolute left-4 top-1/2 transform -translate-y-1/2 text-white bg-neutral-800/50 rounded-full p-2 hover:bg-neutral-700/50 transition-colors z-10"
          on:click|stopPropagation={() => navigateImage(-1)}
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </button>
        
        <!-- Next Button -->
        <button 
          class="absolute right-4 top-1/2 transform -translate-y-1/2 text-white bg-neutral-800/50 rounded-full p-2 hover:bg-neutral-700/50 transition-colors z-10"
          on:click|stopPropagation={() => navigateImage(1)}
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </button>
        
        <!-- Image -->
        <img 
          src={selectedImage.src} 
          alt={selectedImage.alt} 
          class="w-full h-auto max-h-[80vh] object-contain rounded-lg shadow-2xl"
        />
        
        <!-- Caption -->
        <div class="bg-neutral-800 p-4 rounded-b-lg">
          <h3 class="text-white font-bold text-xl">{selectedImage.title}</h3>
          <p class="text-neutral-300">{categories.find(cat => cat.id === selectedImage.category)?.name}</p>
        </div>
      </div>
    </div>
  {/if}
</div>