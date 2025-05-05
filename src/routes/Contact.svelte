<script lang="ts">
  import { onMount } from 'svelte';
  
  // Store hours
  const storeHours = [
    { day: 'Monday', hours: '8:00 AM - 11:00 PM' },
    { day: 'Tuesday', hours: '8:00 AM - 11:00 PM' },
    { day: 'Wednesday', hours: '8:00 AM - 11:00 PM' },
    { day: 'Thursday', hours: '8:00 AM - 11:00 PM' },
    { day: 'Friday', hours: '8:00 AM - 11:00 PM' },
    { day: 'Saturday', hours: '8:00 AM - 11:00 PM' },
    { day: 'Sunday', hours: '8:00 AM - 11:00 PM' }
  ];
  
  // Contact form state
  let name = '';
  let email = '';
  let phone = '';
  let message = '';
  let submitted = false;
  let submitting = false;
  
  function handleSubmit() {
    submitting = true;
    
    // Simulate form submission
    setTimeout(() => {
      submitting = false;
      submitted = true;
      
      // Reset form fields
      name = '';
      email = '';
      phone = '';
      message = '';
    }, 1500);
  }
  
  onMount(() => {
    // Could initialize a map here if using a map library
  });
</script>

<div class="bg-neutral-50 min-h-screen">
  <!-- Hero Section -->
  <section class="relative bg-neutral-900 text-white">
    <div class="relative h-80">
      <img 
        src="https://images.pexels.com/photos/3850838/pexels-photo-3850838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" 
        alt="Contact Us" 
        class="absolute inset-0 w-full h-full object-cover opacity-50"
      />
      <div class="absolute inset-0 bg-gradient-to-r from-neutral-900 to-neutral-900/70"></div>
      <div class="container mx-auto px-4 relative h-full flex items-center">
        <div>
          <h1 class="text-4xl md:text-5xl font-bold mb-4">Contact Us</h1>
          <p class="text-xl max-w-2xl text-neutral-200">We'd love to hear from you! Reach out with questions, feedback, or special orders.</p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Contact Information & Form -->
  <section class="py-16">
    <div class="container mx-auto px-4">
      <div class="flex flex-col lg:flex-row gap-12">
        <!-- Contact Information -->
        <div class="lg:w-1/3">
          <div class="bg-white rounded-lg shadow-md p-8 mb-8">
            <h2 class="text-2xl font-bold mb-6 text-neutral-800">Get In Touch</h2>
            
            <!-- Phone -->
            <div class="flex items-start mb-6">
              <div class="bg-primary-100 rounded-full p-3 mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                </svg>
              </div>
              <div>
                <h3 class="font-bold text-neutral-800">Phone</h3>
                <p class="text-neutral-600">(714) 400-5005</p>
              </div>
            </div>
            
            <!-- Email -->
            <div class="flex items-start mb-6">
              <div class="bg-primary-100 rounded-full p-3 mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
              </div>
              <div>
                <h3 class="font-bold text-neutral-800">Email</h3>
                <p class="text-neutral-600">info@alkarmel.com</p>
              </div>
            </div>
            
            <!-- Address -->
            <div class="flex items-start">
              <div class="bg-primary-100 rounded-full p-3 mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
              </div>
              <div>
                <h3 class="font-bold text-neutral-800">Address</h3>
                <p class="text-neutral-600">521 S Brookhurst St<br />Anaheim, CA 92804</p>
              </div>
            </div>
          </div>
          
          <!-- Store Hours -->
          <div class="bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold mb-6 text-neutral-800">Store Hours</h2>
            <ul class="space-y-2">
              {#each storeHours as { day, hours }}
                <li class="flex justify-between items-center py-2 border-b border-neutral-100">
                  <span class="font-medium text-neutral-800">{day}</span>
                  <span class="text-neutral-600">{hours}</span>
                </li>
              {/each}
            </ul>
          </div>
        </div>
        
        <!-- Contact Form & Map -->
        <div class="lg:w-2/3">
          <!-- Contact Form -->
          <div class="bg-white rounded-lg shadow-md p-8 mb-8">
            <h2 class="text-2xl font-bold mb-6 text-neutral-800">Send Us a Message</h2>
            
            {#if submitted}
              <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded mb-6">
                <p>Thank you for your message! We'll get back to you as soon as possible.</p>
              </div>
            {/if}
            
            <form on:submit|preventDefault={handleSubmit} class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Name -->
                <div>
                  <label for="name" class="block mb-2 text-sm font-medium text-neutral-800">Your Name</label>
                  <input 
                    type="text" 
                    id="name" 
                    bind:value={name} 
                    required 
                    class="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    placeholder="John Doe"
                  />
                </div>
                
                <!-- Email -->
                <div>
                  <label for="email" class="block mb-2 text-sm font-medium text-neutral-800">Email Address</label>
                  <input 
                    type="email" 
                    id="email" 
                    bind:value={email} 
                    required 
                    class="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    placeholder="johndoe@example.com"
                  />
                </div>
                
                <!-- Phone -->
                <div>
                  <label for="phone" class="block mb-2 text-sm font-medium text-neutral-800">Phone Number (Optional)</label>
                  <input 
                    type="tel" 
                    id="phone" 
                    bind:value={phone} 
                    class="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    placeholder="(555) 123-4567"
                  />
                </div>
                
                <!-- Subject -->
                <div>
                  <label for="subject" class="block mb-2 text-sm font-medium text-neutral-800">Subject</label>
                  <select 
                    id="subject" 
                    class="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  >
                    <option>General Inquiry</option>
                    <option>Product Information</option>
                    <option>Special Order Request</option>
                    <option>Feedback</option>
                    <option>Other</option>
                  </select>
                </div>
              </div>
              
              <!-- Message -->
              <div>
                <label for="message" class="block mb-2 text-sm font-medium text-neutral-800">Your Message</label>
                <textarea 
                  id="message" 
                  bind:value={message} 
                  required 
                  rows="4" 
                  class="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  placeholder="How can we help you?"
                ></textarea>
              </div>
              
              <!-- Submit Button -->
              <button 
                type="submit" 
                class="btn btn-primary w-full" 
                disabled={submitting}
              >
                {#if submitting}
                  <span class="flex items-center justify-center">
                    <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Sending...
                  </span>
                {:else}
                  Send Message
                {/if}
              </button>
            </form>
          </div>
          
          <!-- Map -->
          <div class="bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold mb-6 text-neutral-800">Find Us</h2>
            <!-- Placeholder for a map -->
            <div class="aspect-video rounded-lg bg-neutral-100 flex items-center justify-center">
              <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d387193.3060151517!2d-74.25986762856171!3d40.697149421223625!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c24fa5d33f083b%3A0xc80b8f06e177fe62!2sNew%20York%2C%20NY%2C%20USA!5e0!3m2!1sen!2sus!4v1686667649039!5m2!1sen!2sus" 
                width="100%" 
                height="100%" 
                style="border:0;" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade"
                title="Store Location Map"
              ></iframe>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- FAQ Section -->
  <section class="py-16 bg-primary-50">
    <div class="container mx-auto px-4">
      <h2 class="section-title text-center mb-12">Frequently Asked Questions</h2>
      
      <div class="max-w-3xl mx-auto space-y-6">
        <!-- FAQ Item 1 -->
        <details class="bg-white p-6 rounded-lg shadow-sm">
          <summary class="font-bold text-lg cursor-pointer">Do you offer catering services?</summary>
          <div class="mt-4 text-neutral-700">
            <p>Yes, we offer catering services for events of all sizes. We can provide a variety of Middle Eastern dishes, including meat platters, mezze selections, and freshly baked bread. Please contact us at least 48 hours in advance to discuss your catering needs.</p>
          </div>
        </details>
        
        <!-- FAQ Item 2 -->
        <details class="bg-white p-6 rounded-lg shadow-sm">
          <summary class="font-bold text-lg cursor-pointer">Are all your meats halal?</summary>
          <div class="mt-4 text-neutral-700">
            <p>Yes, all of our meats are 100% halal certified. We source our meats from trusted suppliers who adhere to proper halal practices.</p>
          </div>
        </details>
        
        <!-- FAQ Item 3 -->
        <details class="bg-white p-6 rounded-lg shadow-sm">
          <summary class="font-bold text-lg cursor-pointer">Can I place special orders?</summary>
          <div class="mt-4 text-neutral-700">
            <p>Absolutely! We welcome special orders for specific cuts of meat, bakery items, or any other products you might need. Please give us at least 24 hours notice for special orders.</p>
          </div>
        </details>
        
        <!-- FAQ Item 4 -->
        <details class="bg-white p-6 rounded-lg shadow-sm">
          <summary class="font-bold text-lg cursor-pointer">Do you ship your products?</summary>
          <div class="mt-4 text-neutral-700">
            <p>Currently, we do not offer shipping services. All of our products are available for in-store purchase or local delivery within a 10-mile radius for orders over $50.</p>
          </div>
        </details>
        
        <!-- FAQ Item 5 -->
        <details class="bg-white p-6 rounded-lg shadow-sm">
          <summary class="font-bold text-lg cursor-pointer">How fresh is your bread?</summary>
          <div class="mt-4 text-neutral-700">
            <p>Our bread is baked fresh daily in our on-site bakery. We recommend coming in the morning for the freshest selection, though we bake throughout the day as needed.</p>
          </div>
        </details>
      </div>
    </div>
  </section>
</div>