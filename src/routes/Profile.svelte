<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '../lib/supabase';
  import { navigate } from 'svelte-routing';
  import { isAdmin } from '../lib/auth';
  import type { Database } from '../lib/database.types';
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

  let user: any = null;
  let loading = true;
  let error = '';
  let activeTab = 'dashboard';
  let products: Database['public']['Tables']['products']['Row'][] = [];
  let orders: Database['public']['Tables']['orders']['Row'][] = [];
  let showProductForm = false;
  let editingProduct: Database['public']['Tables']['products']['Row'] | null = null;

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

  // Form data
  let productForm = {
    name: '',
    description: '',
    price: 0,
    category: '',
    image: ''
  };

  const categories = [
    { id: 'Spices', name: 'Spices & Seasonings' },
    { id: 'Pantry', name: 'Pantry Items' },
    { id: 'Dairy', name: 'Dairy Products' },
    { id: 'Bread', name: 'Breads' },
    { id: 'Meat', name: 'Meats' },
    { id: 'Sweets', name: 'Sweets & Pastries' },
    { id: 'Dry Goods', name: 'Dry Goods' },
    { id: 'Beverages', name: 'Beverages' }
  ];

  async function fetchProducts() {
    try {
      const { data, error: fetchError } = await supabase
        .from('products')
        .select('*')
        .is('deleted_at', null)
        .order('created_at', { ascending: false });

      if (fetchError) throw fetchError;
      products = data || [];
    } catch (err) {
      console.error('Error fetching products:', err);
    }
  }

  async function fetchOrders() {
    try {
      const { data, error: fetchError } = await supabase
        .from('orders')
        .select('*')
        .is('deleted_at', null)
        .order('created_at', { ascending: false });

      if (fetchError) throw fetchError;
      orders = data || [];
    } catch (err) {
      console.error('Error fetching orders:', err);
    }
  }

  async function handleProductSubmit() {
    try {
      if (editingProduct) {
        const { error: updateError } = await supabase
          .from('products')
          .update({
            name: productForm.name,
            description: productForm.description,
            price: productForm.price,
            category: productForm.category,
            image: productForm.image,
            updated_at: new Date().toISOString()
          })
          .eq('id', editingProduct.id);

        if (updateError) throw updateError;
      } else {
        const { error: insertError } = await supabase
          .from('products')
          .insert([{
            name: productForm.name,
            description: productForm.description,
            price: productForm.price,
            category: productForm.category,
            image: productForm.image
          }]);

        if (insertError) throw insertError;
      }

      resetForm();
      await fetchProducts();
    } catch (err) {
      error = err.message;
    }
  }

  async function deleteProduct(id: string) {
    if (!confirm('Are you sure you want to delete this product?')) return;

    try {
      const { error: deleteError } = await supabase
        .from('products')
        .update({ deleted_at: new Date().toISOString() })
        .eq('id', id);

      if (deleteError) throw deleteError;
      await fetchProducts();
    } catch (err) {
      error = err.message;
    }
  }

  function editProduct(product: Database['public']['Tables']['products']['Row']) {
    editingProduct = product;
    productForm = {
      name: product.name,
      description: product.description || '',
      price: product.price,
      category: product.category || '',
      image: product.image || ''
    };
    showProductForm = true;
  }

  function resetForm() {
    productForm = {
      name: '',
      description: '',
      price: 0,
      category: '',
      image: ''
    };
    editingProduct = null;
    showProductForm = false;
    error = '';
  }

  onMount(async () => {
    try {
      const { data: { user: currentUser }, error: authError } = await supabase.auth.getUser();
      
      if (authError) throw authError;
      if (!currentUser) {
        navigate('/login');
        return;
      }

      user = currentUser;
      if ($isAdmin) {
        await Promise.all([fetchProducts(), fetchOrders()]);
      }
    } catch (err) {
      error = err.message;
    } finally {
      loading = false;
    }
  });

  async function handleSignOut() {
    try {
      const { error: signOutError } = await supabase.auth.signOut();
      if (signOutError) throw signOutError;
      
      localStorage.removeItem('isAdmin');
      navigate('/login');
    } catch (err) {
      error = err.message;
    }
  }
</script>

<div class="min-h-screen bg-neutral-50 py-12">
  <div class="container mx-auto px-4">
    <div class="max-w-6xl mx-auto">
      {#if loading}
        <div class="flex justify-center">
          <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-primary-500"></div>
        </div>
      {:else if error}
        <div class="bg-red-50 text-red-600 p-4 rounded-lg mb-6">
          {error}
        </div>
      {:else}
        <div class="bg-white rounded-lg shadow-md">
          <div class="border-b border-neutral-200">
            <div class="flex justify-between items-center px-8 py-4">
              <h1 class="text-2xl font-bold">Admin Dashboard</h1>
              <button 
                class="btn bg-red-600 hover:bg-red-700 text-white"
                on:click={handleSignOut}
              >
                Sign Out
              </button>
            </div>

            {#if $isAdmin}
              <div class="px-8">
                <nav class="flex space-x-8">
                  <button
                    class={`py-4 text-sm font-medium border-b-2 ${activeTab === 'dashboard' ? 'text-primary-600 border-primary-500' : 'text-neutral-500 border-transparent hover:text-neutral-700 hover:border-neutral-300'}`}
                    on:click={() => activeTab = 'dashboard'}
                  >
                    Dashboard
                  </button>
                  <button
                    class={`py-4 text-sm font-medium border-b-2 ${activeTab === 'products' ? 'text-primary-600 border-primary-500' : 'text-neutral-500 border-transparent hover:text-neutral-700 hover:border-neutral-300'}`}
                    on:click={() => activeTab = 'products'}
                  >
                    Products
                  </button>
                  <button
                    class={`py-4 text-sm font-medium border-b-2 ${activeTab === 'orders' ? 'text-primary-600 border-primary-500' : 'text-neutral-500 border-transparent hover:text-neutral-700 hover:border-neutral-300'}`}
                    on:click={() => activeTab = 'orders'}
                  >
                    Orders
                  </button>
                  <button
                    class={`py-4 text-sm font-medium border-b-2 ${activeTab === 'profile' ? 'text-primary-600 border-primary-500' : 'text-neutral-500 border-transparent hover:text-neutral-700 hover:border-neutral-300'}`}
                    on:click={() => activeTab = 'profile'}
                  >
                    Profile
                  </button>
                </nav>
              </div>
            {/if}
          </div>

          <div class="p-8">
            {#if $isAdmin}
              {#if activeTab === 'dashboard'}
                <!-- Dashboard Content -->
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
                        ${orders.reduce((sum, order) => sum + order.total_amount, 0).toFixed(2)}
                      </p>
                    </div>
                  </div>

                  <!-- Sales Chart -->
                  <div class="bg-white p-6 rounded-lg shadow border">
                    <h3 class="text-lg font-semibold text-neutral-800 mb-4">Sales Overview</h3>
                    <Line data={salesData} options={{ responsive: true }} />
                  </div>
                </div>

              {:else if activeTab === 'products'}
                <!-- Products Content -->
                <div>
                  <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold">Product Management</h2>
                    <button 
                      class="btn btn-primary"
                      on:click={() => {
                        resetForm();
                        showProductForm = true;
                      }}
                    >
                      Add New Product
                    </button>
                  </div>

                  {#if showProductForm}
                    <div class="bg-neutral-50 p-6 rounded-lg mb-8">
                      <h3 class="text-lg font-bold mb-4">
                        {editingProduct ? 'Edit Product' : 'Add New Product'}
                      </h3>
                      
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
                            <select
                              bind:value={productForm.category}
                              class="mt-1 block w-full rounded-md border-neutral-300 shadow-sm focus:border-primary-500 focus:ring-primary-500"
                              required
                            >
                              <option value="">Select a category</option>
                              {#each categories as category}
                                <option value={category.id}>{category.name}</option>
                              {/each}
                            </select>
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
                        
                        <div class="flex justify-end space-x-4">
                          <button 
                            type="button"
                            class="btn bg-neutral-500 hover:bg-neutral-600 text-white"
                            on:click={resetForm}
                          >
                            Cancel
                          </button>
                          <button type="submit" class="btn btn-primary">
                            {editingProduct ? 'Update Product' : 'Add Product'}
                          </button>
                        </div>
                      </form>
                    </div>
                  {/if}

                  <div class="overflow-x-auto">
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
                                <img 
                                  src={product.image} 
                                  alt={product.name} 
                                  class="h-10 w-10 rounded-full object-cover"
                                />
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
                                on:click={() => editProduct(product)}
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

              {:else if activeTab === 'orders'}
                <!-- Orders Content -->
                <div class="overflow-x-auto">
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
                            <div class="text-sm text-neutral-900">{order.user_id}</div>
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
                            <div class="text-sm text-neutral-900">${order.total_amount.toFixed(2)}</div>
                          </td>
                        </tr>
                      {/each}
                    </tbody>
                  </table>
                </div>

              {:else if activeTab === 'profile'}
                <!-- Profile Content -->
                <div class="max-w-2xl">
                  <div class="space-y-4">
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Email</label>
                      <p class="mt-1 text-neutral-900">{user.email}</p>
                    </div>
                    
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Account Created</label>
                      <p class="mt-1 text-neutral-900">
                        {new Date(user.created_at).toLocaleDateString()}
                      </p>
                    </div>
                    
                    <div>
                      <label class="block text-sm font-medium text-neutral-700">Role</label>
                      <p class="mt-1 text-neutral-900">Administrator</p>
                    </div>
                  </div>
                </div>
              {/if}
            {:else}
              <!-- Regular User Profile -->
              <div class="max-w-2xl">
                <div class="space-y-4">
                  <div>
                    <label class="block text-sm font-medium text-neutral-700">Email</label>
                    <p class="mt-1 text-neutral-900">{user.email}</p>
                  </div>
                  
                  <div>
                    <label class="block text-sm font-medium text-neutral-700">Account Created</label>
                    <p class="mt-1 text-neutral-900">
                      {new Date(user.created_at).toLocaleDateString()}
                    </p>
                  </div>
                </div>
              </div>
            {/if}
          </div>
        </div>
      {/if}
    </div>
  </div>
</div>