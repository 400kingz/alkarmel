<script lang="ts">
  import { onMount } from 'svelte';
  import { Link } from 'svelte-routing';
  import ProductCard from '../components/ProductCard.svelte';
  import TestimonialCard from '../components/TestimonialCard.svelte';

  // Featured products
  const featuredProducts = [
    {
      id: 1,
      name: "Fresh Pita Bread",
      category: "Bakery",
      image: "/images/bakery.jpg",
      description: "Freshly baked traditional pita bread, perfect for dipping in hummus or making wraps.",
      price: 3.99
    },
    {
      id: 2,
      name: "Premium Lamb Cuts",
      category: "Meat",
      image: "/images/meat.jpg",
      description: "High-quality lamb cuts, perfect for traditional Middle Eastern dishes.",
      price: 15.99
    },
    {
      id: 3,
      name: "Palestinian Olive Oil",
      category: "Essentials",
      image: "https://images.pexels.com/photos/33783/olive-oil-salad-dressing-cooking-olive.jpg",
      description: "Authentic extra virgin olive oil imported directly from Palestinian olive groves.",
      price: 19.99
    }
  ];

  // Testimonials
  const testimonials = [
    {
      id: 1,
      name: "Sarah K.",
      quote: "I've been looking for authentic Middle Eastern ingredients for years, and Al Karmel has everything I need. The bread is always fresh and delicious!",
      image: "/images/amo.jpg"
    },
    {
      id: 2,
      name: "Ahmed M.",
      quote: "The quality of meat at Al Karmel is exceptional. I always come here for special occasions, and the staff is knowledgeable and friendly.",
      image: "/images/amo.jpg"
    },
    {
      id: 3,
      name: "Leila T.",
      quote: "Finally found a place that sells authentic Palestinian olive oil! Their selection of Arab groceries brings me back to my childhood.",
      image: "/images/amo.jpg"
    }
  ];

  let isAnimating = false;

  onMount(() => {
    // Add animation classes after component mounts
    isAnimating = true;
    
    // Load Instagram embed script
    const script = document.createElement('script');
    script.src = '//www.instagram.com/embed.js';
    script.async = true;
    document.body.appendChild(script);
  });
</script>

<div class="min-h-screen">
  <!-- Hero Section -->
  <section class="relative h-screen flex items-center text-white bg-neutral-900 overflow-hidden">
    <div class="absolute inset-0 z-0">
      <img 
        src="/images/family.jpg" 
        alt="Middle Eastern Food" 
        class="w-full h-full object-cover opacity-60"
      />
      <div class="absolute inset-0 bg-gradient-to-r from-neutral-900 via-neutral-900/70 to-transparent"></div>
    </div>
    
    <div class="container mx-auto px-4 z-10">
      <div class="max-w-2xl">
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold mb-6 leading-tight animate-slide-up">
          A Taste of Home, From Our <span class="text-primary-400">Family</span> to <span class="text-secondary-400">Yours</span>
        </h1>
        <p class="text-lg md:text-xl mb-8 text-neutral-200 animate-slide-up" style="animation-delay: 0.2s">
          Continuing our family's legacy from Palestine, Al Karmel brings you authentic Middle Eastern flavors, fresh-baked bread, and quality halal meats.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 animate-slide-up" style="animation-delay: 0.4s">
          <Link to="/products">
            <button class="btn btn-primary">Browse Products</button>
          </Link>
          <Link to="/contact">
            <button class="btn bg-white text-primary-700 hover:bg-neutral-100">Visit Us</button>
          </Link>
        </div>
      </div>
    </div>
  </section>

  <!-- About Us Teaser -->
  <section class="py-16 bg-neutral-50">
    <div class="container mx-auto px-4">
      <div class="flex flex-col lg:flex-row items-center gap-12">
        <div class="lg:w-1/2">
          <div class="relative">
            <img 
              src="/images/amo.jpg" 
              alt="Our Store" 
              class="rounded-lg shadow-lg object-cover w-full h-96"
            />
            <div class="absolute -bottom-6 -right-6 hidden md:block">
              <img 
                src="/images/snacks.jpg" 
                alt="Fresh Bread" 
                class="rounded-lg shadow-lg w-60 h-40 object-cover border-4 border-white"
              />
            </div>
          </div>
        </div>
        
        <div class="lg:w-1/2">
          <h2 class="section-title">Our Family's Legacy</h2>
          <p class="mb-6 text-neutral-700">
            Welcome to Al Karmel Meat & Bakery, where our story begins in a small family bakery in Ramallah, Palestine. For generations, our family has been perfecting the art of traditional bread-making and Middle Eastern cuisine.
          </p>
          <p class="mb-6 text-neutral-700">
            Today, we continue this legacy in Anaheim, bringing the same dedication to quality and authentic flavors that made our family's bakery a beloved part of the community back home. Every recipe we use and every technique we employ has been passed down through generations.
          </p>
          <Link to="/about">
            <button class="btn btn-primary">Read Our Story</button>
          </Link>
        </div>
      </div>
    </div>
  </section>

  <!-- Instagram Feed -->
  <section class="py-16 bg-white">
    <div class="container mx-auto px-4">
      <div class="flex justify-center">
        <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/alkarmelmarket/?utm_source=ig_embed&amp;utm_campaign=loading" data-instgrm-version="14" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:540px; min-width:326px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:16px;"> <a href="https://www.instagram.com/alkarmelmarket/?utm_source=ig_embed&amp;utm_campaign=loading" style=" background:#FFFFFF; line-height:0; padding:0 0; text-align:center; text-decoration:none; width:100%;" target="_blank"> <div style=" display: flex; flex-direction: row; align-items: center;"> <div style="background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 40px; margin-right: 14px; width: 40px;"></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 100px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 60px;"></div></div></div><div style="padding: 19% 0;"></div> <div style="display:block; height:50px; margin:0 auto 12px; width:50px;"><svg width="50px" height="50px" viewBox="0 0 60 60" version="1.1" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"><g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g transform="translate(-511.000000, -20.000000)" fill="#000000"><g><path d="M556.869,30.41 C554.814,30.41 553.148,32.076 553.148,34.131 C553.148,36.186 554.814,37.852 556.869,37.852 C558.924,37.852 560.59,36.186 560.59,34.131 C560.59,32.076 558.924,30.41 556.869,30.41 M541,60.657 C535.114,60.657 530.342,55.887 530.342,50 C530.342,44.114 535.114,39.342 541,39.342 C546.887,39.342 551.658,44.114 551.658,50 C551.658,55.887 546.887,60.657 541,60.657 M541,33.886 C532.1,33.886 524.886,41.1 524.886,50 C524.886,58.899 532.1,66.113 541,66.113 C549.9,66.113 557.115,58.899 557.115,50 C557.115,41.1 549.9,33.886 541,33.886 M565.378,62.101 C565.244,65.022 564.756,66.606 564.346,67.663 C563.803,69.06 563.154,70.057 562.106,71.106 C561.058,72.155 560.06,72.803 558.662,73.347 C557.607,73.757 556.021,74.244 553.102,74.378 C549.944,74.521 548.997,74.552 541,74.552 C533.003,74.552 532.056,74.521 528.898,74.378 C525.979,74.244 524.393,73.757 523.338,73.347 C521.94,72.803 520.942,72.155 519.894,71.106 C518.846,70.057 518.197,69.06 517.654,67.663 C517.244,66.606 516.755,65.022 516.623,62.101 C516.479,58.943 516.448,57.996 516.448,50 C516.448,42.003 516.479,41.056 516.623,37.899 C516.755,34.978 517.244,33.391 517.654,32.338 C518.197,30.938 518.846,29.942 519.894,28.894 C520.942,27.846 521.94,27.196 523.338,26.654 C524.393,26.244 525.979,25.756 528.898,25.623 C532.057,25.479 533.004,25.448 541,25.448 C548.997,25.448 549.943,25.479 553.102,25.623 C556.021,25.756 557.607,26.244 558.662,26.654 C560.06,27.196 561.058,27.846 562.106,28.894 C563.154,29.942 563.803,30.938 564.346,32.338 C564.756,33.391 565.244,34.978 565.378,37.899 C565.522,41.056 565.552,42.003 565.552,50 C565.552,57.996 565.522,58.943 565.378,62.101 M570.82,37.631 C570.674,34.438 570.167,32.258 569.425,30.349 C568.659,28.377 567.633,26.702 565.965,25.035 C564.297,23.368 562.623,22.342 560.652,21.575 C558.743,20.834 556.562,20.326 553.369,20.18 C550.169,20.033 549.148,20 541,20 C532.853,20 531.831,20.033 528.631,20.18 C525.438,20.326 523.257,20.834 521.349,21.575 C519.376,22.342 517.703,23.368 516.035,25.035 C514.368,26.702 513.342,28.377 512.574,30.349 C511.834,32.258 511.326,34.438 511.181,37.631 C511.035,40.831 511,41.851 511,50 C511,58.147 511.035,59.17 511.181,62.369 C511.326,65.562 511.834,67.743 512.574,69.651 C513.342,71.625 514.368,73.296 516.035,74.965 C517.703,76.634 519.376,77.658 521.349,78.425 C523.257,79.167 525.438,79.673 528.631,79.82 C531.831,79.965 532.853,80.001 541,80.001 C549.148,80.001 550.169,79.965 553.369,79.82 C556.562,79.673 558.743,79.167 560.652,78.425 C562.623,77.658 564.297,76.634 565.965,74.965 C567.633,73.296 568.659,71.625 569.425,69.651 C570.167,67.743 570.674,65.562 570.82,62.369 C570.966,59.17 571,58.147 571,50 C571,41.851 570.966,40.831 570.82,37.631"></path></g></g></g></svg></div><div style="padding-top: 8px;"> <div style=" color:#3897f0; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:550; line-height:18px;">View this profile on Instagram</div></div><div style="padding: 12.5% 0;"></div> <div style="display: flex; flex-direction: row; margin-bottom: 14px; align-items: center;"><div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(0px) translateY(7px);"></div> <div style="background-color: #F4F4F4; height: 12.5px; transform: rotate(-45deg) translateX(3px) translateY(1px); width: 12.5px; flex-grow: 0; margin-right: 14px; margin-left: 2px;"></div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(9px) translateY(-18px);"></div></div><div style="margin-left: 8px;"> <div style=" background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 20px; width: 20px;"></div> <div style=" width: 0; height: 0; border-top: 2px solid transparent; border-left: 6px solid #f4f4f4; border-bottom: 2px solid transparent; transform: translateX(16px) translateY(-4px) rotate(30deg)"></div></div><div style="margin-left: auto;"> <div style=" width: 0px; border-top: 8px solid #F4F4F4; border-right: 8px solid transparent; transform: translateY(16px);"></div> <div style=" background-color: #F4F4F4; flex-grow: 0; height: 12px; width: 16px; transform: translateY(-4px);"></div> <div style=" width: 0; height: 0; border-top: 8px solid #F4F4F4; border-left: 8px solid transparent; transform: translateY(-4px) translateX(8px);"></div></div></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center; margin-bottom: 24px;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 224px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 144px;"></div></div></a><p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;"><a href="https://www.instagram.com/alkarmelmarket/?utm_source=ig_embed&amp;utm_campaign=loading" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px;" target="_blank">AL KARMEL MARKET | بقالة الكرمل</a> (@<a href="https://www.instagram.com/alkarmelmarket/?utm_source=ig_embed&amp;utm_campaign=loading" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px;" target="_blank">alkarmelmarket</a>) • Instagram photos and videos</p></div></blockquote>
      </div>
    </div>
  </section>

  <!-- Featured Products -->
  <section class="py-16 bg-white">
    <div class="container mx-auto px-4">
      <div class="text-center mb-12">
        <h2 class="section-title">Featured Products</h2>
        <p class="max-w-2xl mx-auto text-neutral-600">
          Explore our selection of fresh, authentic Middle Eastern products that bring the taste of tradition to your table.
        </p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {#each featuredProducts as product}
          <ProductCard {product} />
        {/each}
      </div>
      
      <div class="text-center mt-12">
        <Link to="/products">
          <button class="btn btn-primary">View All Products</button>
        </Link>
      </div>
    </div>
  </section>

  <!-- Categories Section -->
  <section class="py-16 bg-neutral-50">
    <div class="container mx-auto px-4">
      <div class="text-center mb-12">
        <h2 class="section-title">Our Categories</h2>
        <p class="max-w-2xl mx-auto text-neutral-600">
          Explore our diverse selection of products across multiple categories
        </p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <!-- Bakery Category -->
        <div class="relative group overflow-hidden rounded-lg shadow-lg h-80">
          <img 
            src="/images/bakery.jpg" 
            alt="Fresh Bakery" 
            class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-neutral-900 to-transparent opacity-80"></div>
          <div class="absolute bottom-0 left-0 p-6 z-10">
            <h3 class="text-white text-2xl font-bold mb-2">Bakery</h3>
            <p class="text-neutral-200 mb-4">Freshly baked pita, manakeesh, and more</p>
            <Link to="/products">
              <button class="bg-white text-primary-700 py-2 px-4 rounded-md font-medium hover:bg-primary-50 transition-colors">View Products</button>
            </Link>
          </div>
        </div>
        
        <!-- Meat Category -->
        <div class="relative group overflow-hidden rounded-lg shadow-lg h-80">
          <img 
            src="/images/meat.jpg" 
            alt="Quality Meats" 
            class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-neutral-900 to-transparent opacity-80"></div>
          <div class="absolute bottom-0 left-0 p-6 z-10">
            <h3 class="text-white text-2xl font-bold mb-2">Fresh Meat</h3>
            <p class="text-neutral-200 mb-4">Premium halal meats and specialties</p>
            <Link to="/products">
              <button class="bg-white text-primary-700 py-2 px-4 rounded-md font-medium hover:bg-primary-50 transition-colors">View Products</button>
            </Link>
          </div>
        </div>
        
        <!-- Essentials Category -->
        <div class="relative group overflow-hidden rounded-lg shadow-lg h-80">
          <img 
            src="/images/fruit.jpg" 
            alt="Arab Essentials" 
            class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-neutral-900 to-transparent opacity-80"></div>
          <div class="absolute bottom-0 left-0 p-6 z-10">
            <h3 class="text-white text-2xl font-bold mb-2">Arab Essentials</h3>
            <p class="text-neutral-200 mb-4">Authentic Middle Eastern groceries</p>
            <Link to="/products">
              <button class="bg-white text-primary-700 py-2 px-4 rounded-md font-medium hover:bg-primary-50 transition-colors">View Products</button>
            </Link>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Testimonials Section -->
  <section class="py-16 bg-primary-50">
    <div class="container mx-auto px-4">
      <div class="text-center mb-12">
        <h2 class="section-title">What Our Customers Say</h2>
        <p class="max-w-2xl mx-auto text-neutral-600">
          Don't just take our word for it - hear from our satisfied customers who love our products
        </p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        {#each testimonials as testimonial}
          <TestimonialCard {testimonial} />
        {/each}
      </div>
    </div>
  </section>
  
  <!-- Call to Action -->
  <section class="py-16 bg-secondary-500 text-white">
    <div class="container mx-auto px-4 text-center">
      <h2 class="text-3xl font-bold mb-6">Ready to Experience Authentic Middle Eastern Flavors?</h2>
      <p class="max-w-2xl mx-auto mb-8 text-white/90">
        Visit our store today to discover our wide selection of fresh meats, bakery items, and authentic Arab groceries.
      </p>
      <div class="flex flex-col sm:flex-row justify-center gap-4">
        <Link to="/products">
          <button class="btn bg-white text-secondary-600 hover:bg-neutral-100">Browse Products</button>
        </Link>
        <Link to="/contact">
          <button class="btn border-2 border-white bg-transparent hover:bg-white/10">Visit Us</button>
        </Link>
      </div>
    </div>
  </section>
</div>