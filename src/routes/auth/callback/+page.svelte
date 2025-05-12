<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { supabase } from '../../../lib/supabase';

  onMount(async () => {
    try {
      const { data: { user }, error } = await supabase.auth.getUser();
      
      if (error) throw error;
      
      if (user) {
        // Check if user is admin
        const { data: adminData } = await supabase
          .from('admins')
          .select('user_id')
          .eq('user_id', user.id)
          .single();

        localStorage.setItem('isAdmin', adminData ? 'true' : 'false');
        navigate(adminData ? '/admin' : '/');
      } else {
        navigate('/login');
      }
    } catch (err) {
      console.error('Auth callback error:', err);
      navigate('/login');
    }
  });
</script>

<div class="min-h-screen flex items-center justify-center">
  <div class="text-center">
    <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-500 mx-auto mb-4"></div>
    <p class="text-neutral-600">Completing authentication...</p>
  </div>
</div>