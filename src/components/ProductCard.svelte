<script lang="ts">
  export let product = {
    id: 0,
    name: "",
    category: "",
    image: "",
    description: "",
    price: 0
  };
</script>

<div class="card group h-full flex flex-col">
  <div class="relative overflow-hidden rounded-lg mb-4">
    <img 
      src={product.image} 
      alt={product.name} 
      class="w-full h-60 object-cover transition-transform duration-500 group-hover:scale-110"
    />
    <div class="absolute top-3 left-3 bg-primary-500 text-white text-sm font-semibold py-1 px-3 rounded-full">
      {product.category}
    </div>
  </div>
  
  <div class="flex-grow">
    <h3 class="text-xl font-bold mb-2 text-neutral-800">{product.name}</h3>
    <p class="text-neutral-600 mb-4">{product.description}</p>
  </div>
  
  <div class="flex justify-between items-center mt-auto">
    <span class="text-xl font-bold text-primary-700">${product.price.toFixed(2)}</span>
    <button class="btn btn-primary py-2 px-4 text-sm">Add to Cart</button>
  </div>
</div>