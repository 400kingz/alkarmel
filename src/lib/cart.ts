import { writable } from 'svelte/store';

export interface CartItem {
  id: string;
  name: string;
  price: number;
  quantity: number;
  stripePriceId: string;
  image: string;
}

function createCart() {
  const { subscribe, set, update } = writable<CartItem[]>([]);

  return {
    subscribe,
    addItem: (item: CartItem) => update(items => {
      const existingItem = items.find(i => i.id === item.id);
      if (existingItem) {
        return items.map(i => 
          i.id === item.id 
            ? { ...i, quantity: i.quantity + 1 }
            : i
        );
      }
      return [...items, { ...item, quantity: 1 }];
    }),
    removeItem: (id: string) => update(items => items.filter(i => i.id !== id)),
    updateQuantity: (id: string, quantity: number) => update(items =>
      items.map(i => i.id === id ? { ...i, quantity } : i)
    ),
    clear: () => set([]),
    getTotal: () => {
      let total = 0;
      subscribe(items => {
        total = items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
      })();
      return total;
    }
  };
}

export const cart = createCart();