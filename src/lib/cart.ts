import { writable } from 'svelte/store';

export interface CartItem {
  id: string;
  name: string;
  price: number;
  quantity: number;
  stripePriceId: string;
  image: string;
  maxQuantity?: number;
}

interface CartStore {
  items: CartItem[];
  total: number;
  itemCount: number;
}

const CART_STORAGE_KEY = 'shopping-cart';

function loadCartFromStorage(): CartItem[] {
  if (typeof window === 'undefined') return [];
  const stored = localStorage.getItem(CART_STORAGE_KEY);
  return stored ? JSON.parse(stored) : [];
}

function saveCartToStorage(items: CartItem[]) {
  if (typeof window === 'undefined') return;
  localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(items));
}

function createCart() {
  const { subscribe, set, update } = writable<CartItem[]>(loadCartFromStorage());

  subscribe((items) => {
    saveCartToStorage(items);
  });

  return {
    subscribe,
    addItem: (item: CartItem) => update(items => {
      const existingItem = items.find(i => i.id === item.id);
      if (existingItem) {
        const newQuantity = existingItem.quantity + 1;
        if (existingItem.maxQuantity && newQuantity > existingItem.maxQuantity) {
          throw new Error(`Cannot add more than ${existingItem.maxQuantity} units of this item`);
        }
        return items.map(i => 
          i.id === item.id 
            ? { ...i, quantity: newQuantity }
            : i
        );
      }
      return [...items, { ...item, quantity: 1 }];
    }),
    removeItem: (id: string) => update(items => items.filter(i => i.id !== id)),
    updateQuantity: (id: string, quantity: number) => update(items => {
      const item = items.find(i => i.id === id);
      if (!item) return items;
      
      if (quantity < 1) {
        return items.filter(i => i.id !== id);
      }
      
      if (item.maxQuantity && quantity > item.maxQuantity) {
        throw new Error(`Cannot add more than ${item.maxQuantity} units of this item`);
      }
      
      return items.map(i => i.id === id ? { ...i, quantity } : i);
    }),
    clear: () => {
      set([]);
      localStorage.removeItem(CART_STORAGE_KEY);
    },
    getTotal: () => {
      let total = 0;
      subscribe(items => {
        total = items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
      })();
      return total;
    },
    getItemCount: () => {
      let count = 0;
      subscribe(items => {
        count = items.reduce((sum, item) => sum + item.quantity, 0);
      })();
      return count;
    }
  };
}

export const cart = createCart();