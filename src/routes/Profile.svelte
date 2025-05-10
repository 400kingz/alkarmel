<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '../lib/supabase';
  import { navigate } from 'svelte-routing';

  let user: any = null;
  let loading = true;
  let error = '';

  onMount(async () => {
    try {
      const { data: { user: currentUser }, error: authError } = await supabase.auth.getUser();
      
      if (authError) throw authError;
      if (!currentUser) {
        navigate('/login');
        return;
      }

      user = currentUser;
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
    <div class="max-w-3xl mx-auto">
      <div class="bg-white rounded-lg shadow-md p-8">
        {#if loading}
          <div class="flex justify-center">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-primary-500"></div>
          </div>
        {:else if error}
          <div class="bg-red-50 text-red-600 p-4 rounded-lg">
            {error}
          </div>
        {:else}
          <h1 class="text-2xl font-bold mb-6">Profile</h1>
          
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
            
            <div class="pt-4">
              <button 
                class="btn btn-primary"
                on:click={handleSignOut}
              >
                Sign Out
              </button>
            </div>
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>