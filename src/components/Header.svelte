<script lang="ts">
  import { Link, navigate } from "svelte-routing";
  import { onMount } from "svelte";
  import { slide } from "svelte/transition";
  
  let scrolled = false;
  let mobileMenuOpen = false;
  
  // Toggle mobile menu visibility
  function toggleMobileMenu() {
    mobileMenuOpen = !mobileMenuOpen;
  }
  
  // Close mobile menu when clicking a link
  function closeMenu() {
    mobileMenuOpen = false;
  }
  
  // Change header style on scroll
  function handleScroll() {
    scrolled = window.scrollY > 50;
  }
  
  onMount(() => {
    window.addEventListener('scroll', handleScroll);
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  });
</script>

<header class={`fixed w-full z-50 transition-all duration-300 ${scrolled ? 'bg-white shadow-md py-2' : 'bg-transparent py-4'}`}>
  <div class="container mx-auto px-4">
    <div class="flex justify-between items-center">
      <!-- Logo -->
      <div class="flex items-center">
        <Link to="/" class="flex items-center">
          <img src="src/assets/images/al karmel transparent.png" alt="Al Karmel" class="h-10 w-10 rounded-full object-cover mr-3">
          <span class={`font-heading font-bold text-xl ${scrolled ? 'text-primary-700' : 'text-primary-500'}`}>
            Al Karmel
          </span>
        </Link>
      </div>
      
      <!-- Desktop Navigation -->
      <nav class="hidden md:flex items-center space-x-6">
        <Link to="/" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Home</Link>
        <Link to="/products" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Products</Link>
        <Link to="/gallery" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Gallery</Link>
        <Link to="/about" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>About</Link>
        <Link to="/contact" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Contact</Link>
        <button class="btn btn-primary ml-4">Order Now</button>
      </nav>
      
      <!-- Mobile Menu Button -->
      <button 
        class="md:hidden text-neutral-800 focus:outline-none" 
        aria-label="Open Menu"
        on:click={toggleMobileMenu}
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          {#if mobileMenuOpen}
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          {:else}
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          {/if}
        </svg>
      </button>
    </div>
    
    <!-- Mobile Navigation -->
    {#if mobileMenuOpen}
      <div transition:slide={{duration: 300}} class="md:hidden pt-4 pb-2">
        <nav class="flex flex-col space-y-4">
          <Link 
            to="/" 
            class="font-medium py-2 transition-colors duration-200 text-neutral-800 hover:text-primary-500"
            on:click={closeMenu}
          >
            Home
          </Link>
          <Link 
            to="/products" 
            class="font-medium py-2 transition-colors duration-200 text-neutral-800 hover:text-primary-500"
            on:click={closeMenu}
          >
            Products
          </Link>
          <Link 
            to="/gallery" 
            class="font-medium py-2 transition-colors duration-200 text-neutral-800 hover:text-primary-500"
            on:click={closeMenu}
          >
            Gallery
          </Link>
          <Link 
            to="/about" 
            class="font-medium py-2 transition-colors duration-200 text-neutral-800 hover:text-primary-500"
            on:click={closeMenu}
          >
            About
          </Link>
          <Link 
            to="/contact" 
            class="font-medium py-2 transition-colors duration-200 text-neutral-800 hover:text-primary-500"
            on:click={closeMenu}
          >
            Contact
          </Link>
          <button class="btn btn-primary w-full">Order Now</button>
        </nav>
      </div>
    {/if}
  </div>
</header>

<!-- Spacer to prevent content from hiding behind fixed header -->
<div class="h-16 md:h-20"></div>