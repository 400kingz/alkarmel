import { writable } from 'svelte/store';
import { supabase } from './supabase';

export const isAdmin = writable<boolean>(false);

export async function checkAdminStatus(userId: string) {
  try {
    const { data, error } = await supabase
      .from('admins')
      .select('user_id')
      .eq('user_id', userId)
      .single();
      
    if (error) {
      if (error.code === 'PGRST116') {
        // No rows found - user is not an admin
        isAdmin.set(false);
        localStorage.setItem('isAdmin', 'false');
        return false;
      }
      throw error;
    }
    
    const adminStatus = !!data;
    isAdmin.set(adminStatus);
    localStorage.setItem('isAdmin', adminStatus.toString());
    
    return adminStatus;
  } catch (err) {
    console.error('Error checking admin status:', err);
    isAdmin.set(false);
    localStorage.setItem('isAdmin', 'false');
    return false;
  }
}