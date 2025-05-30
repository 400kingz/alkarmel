<script lang="ts">
  import { navigate } from "svelte-routing";
  import { supabase } from "../lib/supabase";
  import { checkAdminStatus } from "../lib/auth";
  
  let email = '';
  let password = '';
  let confirmPassword = '';
  let error = '';
  let loading = false;
  let isSignUp = false;
  
  async function handleAuth() {
    loading = true;
    error = '';
    
    try {
      if (isSignUp) {
        if (password !== confirmPassword) {
          throw new Error('Passwords do not match');
        }
        
        const { data: { user }, error: signUpError } = await supabase.auth.signUp({
          email,
          password
        });

        if (signUpError) throw signUpError;
        if (!user) throw new Error('No user returned from signup');
        
        navigate('/auth/callback');
      } else {
        const { data: { user }, error: signInError } = await supabase.auth.signInWithPassword({
          email,
          password
        });

        if (signInError) throw signInError;
        if (!user) throw new Error('No user returned from login');

        // Check if user is admin
        const isUserAdmin = await checkAdminStatus(user.id);
        navigate(isUserAdmin ? '/admin' : '/');
      }
    } catch (err) {
      console.error('Auth error:', err);
      error = err.message;
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen bg-neutral-50 flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
  <div class="max-w-md w-full space-y-8">
    <div>
      <h2 class="mt-6 text-center text-3xl font-bold text-neutral-900">
        {isSignUp ? 'Create an account' : 'Sign in to your account'}
      </h2>
      <p class="mt-2 text-center text-sm text-neutral-600">
        {isSignUp ? 'Already have an account?' : "Don't have an account?"} 
        <button 
          class="font-medium text-primary-600 hover:text-primary-500"
          on:click={() => {
            isSignUp = !isSignUp;
            error = '';
          }}
        >
          {isSignUp ? 'Sign in' : 'Sign up'}
        </button>
      </p>
    </div>
    
    <form class="mt-8 space-y-6" on:submit|preventDefault={handleAuth}>
      {#if error}
        <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-md">
          {error}
        </div>
      {/if}
      
      <div class="rounded-md shadow-sm space-y-4">
        <div>
          <label for="email" class="sr-only">Email</label>
          <input
            id="email"
            name="email"
            type="email"
            required
            bind:value={email}
            class="appearance-none rounded-lg relative block w-full px-3 py-2 border border-neutral-300 placeholder-neutral-500 text-neutral-900 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 focus:z-10 sm:text-sm"
            placeholder="Email address"
          />
        </div>
        
        <div>
          <label for="password" class="sr-only">Password</label>
          <input
            id="password"
            name="password"
            type="password"
            required
            bind:value={password}
            class="appearance-none rounded-lg relative block w-full px-3 py-2 border border-neutral-300 placeholder-neutral-500 text-neutral-900 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 focus:z-10 sm:text-sm"
            placeholder="Password"
          />
        </div>

        {#if isSignUp}
          <div>
            <label for="confirmPassword" class="sr-only">Confirm Password</label>
            <input
              id="confirmPassword"
              name="confirmPassword"
              type="password"
              required
              bind:value={confirmPassword}
              class="appearance-none rounded-lg relative block w-full px-3 py-2 border border-neutral-300 placeholder-neutral-500 text-neutral-900 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500 focus:z-10 sm:text-sm"
              placeholder="Confirm Password"
            />
          </div>
        {/if}
      </div>

      <div>
        <button
          type="submit"
          disabled={loading}
          class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
        >
          {#if loading}
            <span class="flex items-center justify-center">
              <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              {isSignUp ? 'Creating account...' : 'Signing in...'}
            </span>
          {:else}
            {isSignUp ? 'Create Account' : 'Sign in'}
          {/if}
        </button>
      </div>
    </form>
  </div>
</div>