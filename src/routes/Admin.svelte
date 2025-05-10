<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '../lib/supabase';
  import { navigate } from 'svelte-routing';
  import { Line } from 'svelte-chartjs';
  import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
  } from 'chart.js';

  ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
  );

  let products = [];
  let orders = [];
  let activeTab = 'dashboard';
  let loading = true;
  let error = null;

  // Form data for new/edit product
  let productForm = {
    name: '',
    description: '',
    price: 0,
    category: '',
    image: '',
    stripe_product_id: '',
    stripe_price_id: ''
  };

  // Sales data for chart
  let salesData = {
    labels: ['January', 'February', 'March', 'April', 'May', 'June'],
    datasets: [{
      label: 'Sales',
      data: [65, 59, 80, 81, 56, 55],
      fill: false,
      borderColor: 'rgb(75, 192, 192)',
      tension: 0.1
    }]
  };

  onMount(async () => {
    // Check if user is authenticated and has admin role
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      navigate('/login');
      return;
    }

    try {
      // Fetch products
      const { data: productsData, error: productsError } = await supabase
        .from('products')
        .select('*');

      if (productsError) throw productsError;
      products = productsData;

      // Fetch orders
      const { data: ordersData, error: ordersError } = await supabase
        .from('orders')
        .select('*');

      if (ordersError) throw ordersError;
      orders = ordersData;

    } catch (err) {
      error = err.message;
    } finally {
      loading = false;
    }
  });

  async function handleProductSubmit() {
    try {
      const { data, error: submitError } = await supabase
        .from('products')
        .insert([productForm]);

      if (submitError) throw submitError;

      // Reset form and refresh products
      productForm = {
        name: '',
        description: '',
        price: 0,
        category: '',
        image: '',
        stripe_product_id: '',
        stripe_price_id: ''
      };

      const { data: refreshedProducts } = await supabase
        .from('products')
        .select('*');
      products = refreshedProducts;

    } catch (err) {
      error = err.message;
    }
  }

  async function deleteProduct(id: string) {
    if (!confirm('Are you sure you want to delete this product?')) return;

    try {
      const { error: deleteError } = await supabase
        .from('products')
        .delete()
        .eq('id', id);

      if (deleteError) throw deleteError;

      products = products.filter(p => p.id !== id);
    } catch (err) {
      error = err.message;
    }
  }
</script>

<div class="min-h-screen bg-neutral-50">
  <div class="container mx-auto px-4 py-8">
    <div class="bg-white rounded-lg shadow-lg overflow-hidden">
      <!-- Navigation Tabs -->
      <div class="border-b">
        <nav class="flex">
          <button
            class={`px-6 py-4 text-sm font-medium ${activeTab === 'dashboard' ? 'text-primary-600 border-b-2 border-primary-500' : 'text-neutral-500 hover:text-neutral-700'}`}
            on:click={() => activeTab = 'dashboard'}
          >
            Dashboard
          </button>
          <button
            class={`px-6 py-4 text-sm font-medium ${activeTab === 'products' ? 'text-primary-600 border-b-2 border-primary-500' : 'text-neutral-500 hover:text-neutral-700'}`}
            on:click={() => activeTab = 'products'}
          >
            Products
          </button>
          <button
            class={`px-6 py-4 text-sm font-medium ${activeTab === 'orders' ? 'text-primary-600 border-b-2 border-primary-500' : 'text-neutral-500 hover:text-neutral-700'}`}
            on:click={() => activeTab = 'orders'}
          >
            Orders
          </button>
        </nav>
      </div>

      <!-- Content Area -->
      <div class="p-6">
        {#if loading}
          <div class="flex justify-center items-center h-64">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-primary-500"></div>
          </div>
        {:else if error}
          <div class="bg-red-50 text-red-500 p-4 rounded-lg">
            {error}
          </div>
        {:else}
          <!-- Dashboard Tab -->
          {#if activeTab === 'dashboard'}
            <div class="space-y-6">
              <!-- Stats Cards -->
              <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-lg shadow border">
                  <h3 class="text-lg font-semibold text-neutral-800">Total Products</h3>
                  <p class="text-3xl font-bold text-primary-600">{products.length}</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow border">
                  <h3 class="text-lg font-semibold text-neutral-800">Total Orders</h3>
                  <p class="text-3xl font-bold text-primary-600">{orders.length}</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow border">
                  <h3 class="text-lg font-semibold text-neutral-800">Revenue</h3>
                  <p class="text-3xl font-bold text-primary-600">
                    ${orders.reduce((sum, order) => sum + order.total, 0).toFixed(2)}
                  </p>
                </div>
              </div>

              <!-- Sales Chart -->
              <div class="bg-white p-6 rounded-lg shadow border">
                <h3 class="text-lg font-semibold text-neutral-800 mb-4">Sales Overview</h3>
                <Line data={salesData} options={{ responsive: true }} />
              </div>
            </div>

          <!-- Products Tab -->
          {:else if activeTab === 'products'}
            <div class="space-y-6">
              <!-- Add Product Form -->
              <div class="bg-white p-6 rounded-lg shadow border">
                <h3 class="text-lg font-semibold text-neutral-800 mb-4">Add New Product</h3>
                <form on:submit|preventDefault={handleProductSubmit} class="space-y-4">
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Name</label>
                      <input
                        type="text"
                        bind:value={productForm.name}
                        class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
                        required
                      />
                    </div>
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Category</label>
                      <input
                        type="text"
                        bind:value={productForm.category}
                        class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
                        required
                      />
                    </div>
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Price</label>
                      <input
                        type="number"
                        bind:value={productForm.price}
                        step="0.01"
                        class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
                        required
                      />
                    </div>
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Image URL</label>
                      <input
                        type="url"
                        bind:value={productForm.image}
                        class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
                        required
                      />
                    </div>
                  </div>
                  <div>
                    <label class="block text-sm font-medium text-neutral-700">Description</label>
                    <textarea
                      bind:value={productForm.description}
                      rows="3"
                      class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
                      required
                    ></textarea>
                  </div>
                  <button type="submit" class="btn btn-primary">Add Product</button>
                </form>
              </div>

              <!-- Products Table -->
              <div class="bg-white rounded-lg shadow border overflow-hidden">
                <table class="min-w-full divide-y divide-neutral-200">
                  <thead class="bg-neutral-50">
                    <tr>
                      <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Product</th>
                      <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Category</th>
                      <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Price</th>
                      <th class="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">Actions</th>
                    </tr>
                  </thead>
                  <tbody class="bg-white divide-y divide-neutral-200">
                    {#each products as product}
                      <tr>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <div class="flex items-center">
                            <img src={product.image} alt={product.name} class="h-10 w-10 rounded-full object-cover" />
                            <div class="ml-4">
                              <div class="text-sm font-medium text-neutral-900">{product.name}</div>
                            </div>
                          </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <div class="text-sm text-neutral-900">{product.category}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <div class="text-sm text-neutral-900">${product.price.toFixed(2)}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                          <button
                            class="text-primary-600 hover:text-primary-900 mr-4"
                            on:click={() => {
                              productForm = { ...product };
                              // TODO: Implement edit functionality
                            }}
                          >
                            Edit
                          </button>
                          <button
                            class="text-red-600 hover:text-red-900"
                            on:click={() => deleteProduct(product.id)}
                          >
                            Delete
                          </button>
                        </td>
                      </tr>
                    {/each}
                  </tbody>
                </table>
              </div>
            </div>

          <!-- Orders Tab -->
          {:else if activeTab === 'orders'}
            <div class="bg-white rounded-lg shadow border overflow-hidden">
              <table class="min-w-full divide-y divide-neutral-200">
                <thead class="bg-neutral-50">
                  <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Order ID</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Customer</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">Total</th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-neutral-200">
                  {#each orders as order}
                    <tr>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-neutral-900">{order.id}</div>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-neutral-900">{order.customer_email}</div>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-neutral-900">
                          {new Date(order.created_at).toLocaleDateString()}
                        </div>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <span class={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                          ${order.status === 'completed' ? 'bg-green-100 text-green-800' :
                          order.status === 'pending' ? 'bg-yellow-100 text-yellow-800' :
                          'bg-neutral-100 text-neutral-800'}`}>
                          {order.status}
                        </span>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-neutral-900">${order.total.toFixed(2)}</div>
                      </td>
                    </tr>
                  {/each}
                </tbody>
              </table>
            </div>
          {/if}
        {/if}
      </div>
    </div>
  </div>
</div>