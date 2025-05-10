export const products = {
  test: {
    priceId: 'price_1Pv2PFASGlIIwkVHicDhqcVF',
    mode: 'payment',
    name: 'Test Product',
    description: 'A test product for development',
    price: 1.00
  }
} as const;

export type ProductId = keyof typeof products;