<script lang="ts">
  import { onMount } from 'svelte';
  
  // Team members
  const teamMembers = [
    {
      name: "Abu Ahmad",
      role: "Founder",
      image: "",
      bio: "Carrying forward his family's legacy from their beloved bakery in Palestine, Abu Ahmad established Al Karmel to share authentic flavors and traditions with our community."
    },
    {
      name: "Ahmad",
      role: "Head Baker",
      image: "",
      bio: "Learning the art of baking from his father in their hometown of Ramallah, Ahmad continues the family tradition of crafting fresh bread daily."
    },
    {
      name: "Mohammed",
      role: "Master Butcher",
      image: "",
      bio: "With expertise passed down through generations, Mohammed ensures every cut of meat meets our family's high standards of quality and tradition."
    }
  ];
  
  // Timeline events
  const timeline = [
    {
      year: 1975,
      title: "Our Roots in Palestine",
      description: "The family's first bakery opens in Ramallah, Palestine, becoming known for its fresh bread and warm hospitality."
    },
    {
      year: 1995,
      title: "A New Beginning",
      description: "The family brings their culinary traditions to America, dreaming of sharing their heritage with a new community."
    },
    {
      year: 2005,
      title: "Al Karmel Opens Its Doors",
      description: "Building on decades of family expertise, Al Karmel Meat & Bakery opens in Anaheim, continuing our legacy of quality and tradition."
    },
    {
      year: 2015,
      title: "Expanding Our Heritage",
      description: "We expanded our selection to include more traditional products, helping our community stay connected to their roots."
    },
    {
      year: 2023,
      title: "Growing Together",
      description: "Now serving second-generation customers, we continue our family's commitment to authentic flavors and warm hospitality."
    }
  ];
  
  let animate = false;
  
  onMount(() => {
    // Trigger animations after component mounts
    animate = true;
  });
</script>

<div class="bg-neutral-50 min-h-screen">
  <!-- Hero Section -->
  <section class="relative bg-neutral-900 text-white">
    <div class="relative h-96">
      <img 
        src="https://images.pexels.com/photos/2233729/pexels-photo-2233729.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" 
        alt="Al Karmel Market" 
        class="absolute inset-0 w-full h-full object-cover opacity-40"
      />
      <div class="absolute inset-0 bg-gradient-to-r from-neutral-900 to-neutral-900/70"></div>
      <div class="container mx-auto px-4 relative h-full flex items-center">
        <div>
          <h1 class="text-4xl md:text-5xl font-bold mb-4">Our Family Story</h1>
          <p class="text-xl max-w-2xl text-neutral-200">From our family's bakery in Palestine to your table in America, we bring generations of tradition and authentic flavors to our community.</p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Our Mission -->
  <section class="py-16">
    <div class="container mx-auto px-4">
      <div class="flex flex-col md:flex-row gap-12 items-center">
        <div class="md:w-1/2">
          <h2 class="section-title">Our Mission</h2>
          <p class="mb-4 text-neutral-700">
            At Al Karmel Meat & Bakery, we carry forward a legacy that began generations ago in our family's bakery in Ramallah, Palestine. Our mission is to share the authentic tastes and traditions that have been passed down through our family for decades.
          </p>
          <p class="mb-4 text-neutral-700">
            Every loaf of bread we bake and every cut of meat we prepare is a continuation of the recipes and techniques our family has perfected over generations. We believe that food is more than sustenance—it's a bridge that connects our community to their heritage.
          </p>
          <p class="text-neutral-700">
            Just as our family's bakery in Palestine was a gathering place for the community, Al Karmel strives to be a home away from home, where the aromas and flavors transport you back to the warm hospitality of the Middle East.
          </p>
        </div>
        <div class="md:w-1/2">
          <div class="relative">
            <img 
              src="https://images.pexels.com/photos/1267320/pexels-photo-1267320.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" 
              alt="Our Store" 
              class="rounded-lg shadow-lg w-full object-cover"
            />
            <div class="absolute top-4 right-4 bg-primary-500 text-white px-6 py-3 rounded-full shadow-lg transform rotate-6">
              <span class="font-bold">Family Owned Since 1975</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Our Values -->
  <section class="py-16 bg-white">
    <div class="container mx-auto px-4">
      <h2 class="section-title text-center mb-12">Our Family Values</h2>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <!-- Tradition -->
        <div class="bg-primary-50 p-8 rounded-lg border-t-4 border-primary-500 shadow-sm">
          <div class="bg-primary-500 text-white rounded-full w-14 h-14 flex items-center justify-center mb-4 mx-auto">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7" />
            </svg>
          </div>
          <h3 class="text-xl font-bold text-center mb-3">Family Tradition</h3>
          <p class="text-neutral-700 text-center">
            We preserve and share the authentic recipes and techniques passed down through generations of our family in Palestine.
          </p>
        </div>
        
        <!-- Quality -->
        <div class="bg-secondary-50 p-8 rounded-lg border-t-4 border-secondary-500 shadow-sm">
          <div class="bg-secondary-500 text-white rounded-full w-14 h-14 flex items-center justify-center mb-4 mx-auto">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <h3 class="text-xl font-bold text-center mb-3">Quality</h3>
          <p class="text-neutral-700 text-center">
            Just like our family's bakery in Palestine, we maintain the highest standards in every product we offer.
          </p>
        </div>
        
        <!-- Community -->
        <div class="bg-primary-50 p-8 rounded-lg border-t-4 border-primary-500 shadow-sm">
          <div class="bg-primary-500 text-white rounded-full w-14 h-14 flex items-center justify-center mb-4 mx-auto">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </div>
          <h3 class="text-xl font-bold text-center mb-3">Family & Community</h3>
          <p class="text-neutral-700 text-center">
            We treat every customer as family, creating a warm and welcoming space that reminds them of home.
          </p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Our Journey Timeline -->
  <section class="py-16">
    <div class="container mx-auto px-4">
      <h2 class="section-title text-center mb-12">Our Family Journey</h2>
      
      <div class="relative">
        <!-- Vertical Line -->
        <div class="absolute left-1/2 transform -translate-x-1/2 h-full w-1 bg-primary-200"></div>
        
        <!-- Timeline Events -->
        {#each timeline as event, index}
          <div class={`flex flex-col md:flex-row md:justify-between items-center mb-12 ${index % 2 === 0 ? 'md:flex-row' : 'md:flex-row-reverse'}`}>
            <!-- Year Marker -->
            <div class="order-1 md:w-5/12"></div>
            
            <!-- Center Point -->
            <div class="z-10 flex items-center order-1 bg-primary-500 shadow-md w-12 h-12 rounded-full mx-auto md:mx-0">
              <h2 class="mx-auto text-white font-semibold text-lg">{event.year}</h2>
            </div>
            
            <!-- Content -->
            <div class={`order-1 bg-white rounded-lg shadow-md px-6 py-4 md:w-5/12 ${animate ? 'animate-fade-in' : ''}`} style={`animation-delay: ${index * 0.2}s`}>
              <h3 class="font-bold text-xl mb-1 text-primary-700">{event.title}</h3>
              <p class="text-neutral-600 text-sm">{event.description}</p>
            </div>
          </div>
        {/each}
      </div>
    </div>
  </section>
  
  <!-- Meet Our Family -->
  <section class="py-16 bg-white">
    <div class="container mx-auto px-4">
      <h2 class="section-title text-center mb-12">Meet Our Family</h2>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        {#each teamMembers as member, index}
          <div class={`card text-center ${animate ? 'animate-fade-in' : ''}`} style={`animation-delay: ${index * 0.2}s`}>
            <img 
              src={member.image} 
              alt={member.name} 
              class="w-32 h-32 rounded-full mx-auto mb-4 object-cover"
            />
            <h3 class="text-xl font-bold mb-1">{member.name}</h3>
            <p class="text-primary-600 font-medium mb-3">{member.role}</p>
            <p class="text-neutral-600">{member.bio}</p>
          </div>
        {/each}
      </div>
    </div>
  </section>
  
  <!-- Call to Action -->
  <section class="py-16 bg-primary-500 text-white">
    <div class="container mx-auto px-4 text-center">
      <h2 class="text-3xl font-bold mb-6">Experience Our Family's Tradition</h2>
      <p class="max-w-2xl mx-auto mb-8">
        Visit Al Karmel today and discover why our family's commitment to quality and tradition has made us a trusted part of the community for generations.
      </p>
      <a href="/contact" class="btn bg-white text-primary-700 hover:bg-neutral-100">Visit Us Today</a>
    </div>
  </section>
</div>