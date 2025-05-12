<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { supabase } from '../../../lib/supabase';
  import { checkAdminStatus } from '../../../lib/auth';

  onMount(async () => {
    try {
      const { data: { user }, error } = await supabase.auth.getUser();
      
      if (error) throw error;
      
      if (user) {
        const isUserAdmin = await checkAdminStatus(user.id);
        navigate(isUserAdmin ? '/admin' : '/');
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