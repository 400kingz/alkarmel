<script lang="ts">
  import { Link, navigate } from "svelte-routing";
  import { onMount } from "svelte";
  import { slide } from "svelte/transition";
  import { supabase } from "../lib/supabase";
  import { isAdmin } from "../lib/auth";
  
  let scrolled = false;
  let mobileMenuOpen = false;
  let user: any = null;
  let profileDropdownOpen = false;
  
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

  async function handleSignOut() {
    try {
      const { error } = await supabase.auth.signOut();
      if (error) throw error;
      
      localStorage.removeItem('isAdmin');
      navigate('/login');
    } catch (err) {
      console.error('Sign out error:', err);
    }
  }
  
  onMount(async () => {
    window.addEventListener('scroll', handleScroll);
    
    const { data: { user: currentUser } } = await supabase.auth.getUser();
    user = currentUser;
    
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
          <img src="/images/al karmel transparent.png" alt="Al Karmel" class="h-10 w-10 rounded-full object-cover mr-3">
          <span class={`font-heading font-bold text-xl ${scrolled ? 'text-primary-700' : 'text-primary-500'}`}>
            Al Karmel
          </span>
        </Link>
      </div>
      
      <!-- Desktop Navigation -->
      <nav class="hidden md:flex items-center space-x-6">
        {#if $isAdmin}
          <!-- Admin Navigation -->
          <Link to="/admin" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Dashboard</Link>
          <Link to="/admin" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Products</Link>
          <Link to="/admin" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Orders</Link>
        {:else}
          <!-- Customer Navigation -->
          <Link to="/" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Home</Link>
          <Link to="/products" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Products</Link>
          <Link to="/gallery" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Gallery</Link>
          <Link to="/about" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>About</Link>
          <Link to="/contact" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Contact</Link>
        {/if}
        
        {#if user}
          <!-- Profile Dropdown -->
          <div class="relative">
            <button 
              class={`flex items-center space-x-1 font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}
              on:click={() => profileDropdownOpen = !profileDropdownOpen}
            >
              <span>Profile</span>
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>
            
            {#if profileDropdownOpen}
              <div 
                class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1"
                transition:slide={{ duration: 200 }}
              >
                <Link 
                  to="/profile" 
                  class="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100"
                  on:click={() => profileDropdownOpen = false}
                >
                  View Profile
                </Link>
                <button 
                  class="block w-full text-left px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100"
                  on:click={handleSignOut}
                >
                  Sign Out
                </button>
              </div>
            {/if}
          </div>
        {:else}
          <Link to="/login" class={`font-medium transition-colors duration-200 ${scrolled ? 'text-neutral-700 hover:text-primary-600' : 'text-neutral-800 hover:text-primary-500'}`}>Login</Link>
        {/if}
        
        {#if !$isAdmin}
          <button class="btn btn-primary ml-4">Order Now</button>
        {/if}
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
      <nav 
        transition:slide={{duration: 300}} 
        class="md:hidden bg-white mt-4 py-4 px-2 rounded-lg shadow-lg"
      >
        <div class="flex flex-col space-y-4">
          {#if $isAdmin}
            <!-- Admin Mobile Navigation -->
            <Link 
              to="/admin" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Dashboard
            </Link>
            <Link 
              to="/admin" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Products
            </Link>
            <Link 
              to="/admin" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Orders
            </Link>
          {:else}
            <!-- Customer Mobile Navigation -->
            <Link 
              to="/" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Home
            </Link>
            <Link 
              to="/products" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Products
            </Link>
            <Link 
              to="/gallery" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Gallery
            </Link>
            <Link 
              to="/about" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              About
            </Link>
            <Link 
              to="/contact" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Contact
            </Link>
          {/if}
          
          {#if user}
            <Link 
              to="/profile" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Profile
            </Link>
            <button 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600 text-left w-full"
              on:click={() => {
                handleSignOut();
                closeMenu();
              }}
            >
              Sign Out
            </button>
          {:else}
            <Link 
              to="/login" 
              class="font-medium py-2 px-4 rounded-md transition-colors duration-200 text-neutral-800 hover:bg-primary-50 hover:text-primary-600"
              on:click={closeMenu}
            >
              Login
            </Link>
          {/if}
          
          {#if !$isAdmin}
            <button class="btn btn-primary w-full">Order Now</button>
          {/if}
        </div>
      </nav>
    {/if}
  </div>
</header>

<!-- Spacer to prevent content from hiding behind fixed header -->
<div class="h-16 md:h-20"></div>