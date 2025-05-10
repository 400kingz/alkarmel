<script lang="ts">
  import { onMount } from 'svelte';
  
  // Team members
  const teamMembers = [
    {
      name: "Ziyad",
      role: "Head Chef & Recipe Master",
      image: "",
      bio: "With an innate understanding of flavors and spices, Ziyad crafts the heartwarming recipes that have been passed down through generations, ensuring every dish tells our family's story."
    },
    {
      name: "Sanad",
      role: "Hospitality Director",
      image: "",
      bio: "As the master of hospitality, Sanad ensures that every guest feels like a welcome member of the Al Karmel family, creating an atmosphere of warmth and belonging."
    },
    {
      name: "Mwafaq",
      role: "Quality & Operations",
      image: "",
      bio: "With meticulous attention to detail, Mwafaq sources the freshest ingredients and oversees kitchen operations to maintain the highest standards of quality in every dish we serve."
    }
  ];
  
  // Timeline events
  const timeline = [
    {
      year: 1975,
      title: "Our Culinary Heritage",
      description: "Our family's culinary journey begins in the heart of Palestine, where traditional recipes and cooking techniques were passed down through generations."
    },
    {
      year: 2014,
      title: "A New Beginning",
      description: "Our family brings their culinary dreams to America, carrying with them the authentic flavors and traditions of our homeland."
    },
    {
      year: 2025,
      title: "Al Karmel Opens Its Doors",
      description: "Three brothers - Ziyad, Sanad, and Mwafaq - unite to establish Al Karmel, bringing authentic home-style Middle Eastern cuisine to our community."
    },
    {
      year: 2025,
      title: "Growing Together",
      description: "We continue to expand our menu while staying true to our family recipes, creating a welcoming space where every guest feels at home."
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
        src="https://images.pexels.com/photos/3850838/pexels-photo-3850838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" 
        alt="Al Karmel Market" 
        class="absolute inset-0 w-full h-full object-cover opacity-40"
      />
      <div class="absolute inset-0 bg-gradient-to-r from-neutral-900 to-neutral-900/70"></div>
      <div class="container mx-auto px-4 relative h-full flex items-center">
        <div>
          <h1 class="text-4xl md:text-5xl font-bold mb-4">Our Family Story</h1>
          <p class="text-xl max-w-2xl text-neutral-200">From our family's kitchen to your table, we bring generations of tradition and authentic flavors to our community.</p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Our Story -->
  <section class="py-16">
    <div class="container mx-auto px-4">
      <div class="flex flex-col md:flex-row gap-12 items-center">
        <div class="md:w-1/2">
          <div class="relative">
            <img 
              src="https://images.pexels.com/photos/6287295/pexels-photo-6287295.jpeg" 
              alt="The Al Karmel Brothers" 
              class="rounded-lg shadow-lg w-full object-cover"
            />
            <div class="absolute top-4 right-4 bg-primary-500 text-white px-6 py-3 rounded-full shadow-lg transform rotate-6">
              <span class="font-bold">Est. 2025</span>
            </div>
          </div>
        </div>
        <div class="md:w-1/2">
          <h2 class="section-title">Our Story</h2>
          <p class="mb-6 text-neutral-700">
            In early 2025, three brothers, Ziyad, Sanad, and Mwafaq, embarked on a shared journey fueled by a singular vision: to bring the authentic, home-style cooking of their heritage to their community. Al Karmel is more than just a restaurant; it's a taste of home, a celebration of family bonds, and a tribute to their rich culinary traditions.
          </p>
          <p class="mb-6 text-neutral-700">
            Each brother brings a unique set of skills and passions to Al Karmel. Ziyad, with his innate understanding of flavors and spices, crafts the heartwarming recipes that have been passed down through generations. Sanad, the master of hospitality, ensures that every guest feels like a welcome member of the Al Karmel family. Mwafaq, with his meticulous attention to detail, sources the freshest ingredients and oversees the kitchen to maintain the highest standards of quality.
          </p>
          <p class="mb-6 text-neutral-700">
            Our family recipes and traditions are the soul of Al Karmel. From the fragrant spices that fill the air to the time-honored techniques used in every dish, we strive to recreate the warmth and comfort of a home-cooked meal. We are committed to providing a welcoming atmosphere where you can gather with loved ones and savor the true taste of home.
          </p>
          <p class="text-neutral-700">
            As we embarked on this fresh start in 2025, we knew that we wanted to honor our heritage while creating a space where everyone feels like family. At Al Karmel, you're not just a customer; you're a cherished guest, invited to share in our family's culinary legacy.
          </p>
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
            We preserve and share the authentic recipes and techniques passed down through generations of our family.
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
            We maintain the highest standards in every dish we serve, using only the freshest and finest ingredients.
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
            We treat every guest as family, creating a warm and welcoming space that reminds them of home.
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
              src={member.image || "https://images.pexels.com/photos/3814446/pexels-photo-3814446.jpeg"} 
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
        Visit Al Karmel today and discover why our family's commitment to quality and tradition has made us a cherished part of the community.
      </p>
      <a href="/contact" class="btn bg-white text-primary-700 hover:bg-neutral-100">Visit Us Today</a>
    </div>
  </section>
</div>