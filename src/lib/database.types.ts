export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      admins: {
        Row: {
          user_id: string
        }
        Insert: {
          user_id: string
        }
        Update: {
          user_id?: string
        }
      }
      products: {
        Row: {
          id: string
          name: string
          description: string | null
          price: number
          category: string | null
          image: string | null
          stripe_product_id: string | null
          stripe_price_id: string | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          name: string
          description?: string | null
          price: number
          category?: string | null
          image?: string | null
          stripe_product_id?: string | null
          stripe_price_id?: string | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: {
          id?: string
          name?: string
          description?: string | null
          price?: number
          category?: string | null
          image?: string | null
          stripe_product_id?: string | null
          stripe_price_id?: string | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
      }
      orders: {
        Row: {
          id: string
          user_id: string
          status: string
          total_amount: number
          items: Json
          shipping_address: Json | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          user_id: string
          status?: string
          total_amount: number
          items?: Json
          shipping_address?: Json | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          status?: string
          total_amount?: number
          items?: Json
          shipping_address?: Json | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
      }
      stripe_customers: {
        Row: {
          id: number
          user_id: string
          customer_id: string
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: number
          user_id: string
          customer_id: string
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: {
          id?: number
          user_id?: string
          customer_id?: string
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
      }
      stripe_orders: {
        Row: {
          id: number
          checkout_session_id: string
          payment_intent_id: string
          customer_id: string
          amount_subtotal: number
          amount_total: number
          currency: string
          payment_status: string
          status: string
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: number
          checkout_session_id: string
          payment_intent_id: string
          customer_id: string
          amount_subtotal: number
          amount_total: number
          currency: string
          payment_status: string
          status?: string
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: {
          id?: number
          checkout_session_id?: string
          payment_intent_id?: string
          customer_id?: string
          amount_subtotal?: number
          amount_total?: number
          currency?: string
          payment_status?: string
          status?: string
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
      }
      stripe_subscriptions: {
        Row: {
          id: number
          customer_id: string
          subscription_id: string | null
          price_id: string | null
          current_period_start: number | null
          current_period_end: number | null
          cancel_at_period_end: boolean | null
          payment_method_brand: string | null
          payment_method_last4: string | null
          status: string
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: number
          customer_id: string
          subscription_id?: string | null
          price_id?: string | null
          current_period_start?: number | null
          current_period_end?: number | null
          cancel_at_period_end?: boolean | null
          payment_method_brand?: string | null
          payment_method_last4?: string | null
          status: string
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: {
          id?: number
          customer_id?: string
          subscription_id?: string | null
          price_id?: string | null
          current_period_start?: number | null
          current_period_end?: number | null
          cancel_at_period_end?: boolean | null
          payment_method_brand?: string | null
          payment_method_last4?: string | null
          status?: string
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
      }
    }
    Views: {
      stripe_user_orders: {
        Row: {
          amount_subtotal: number | null
          amount_total: number | null
          checkout_session_id: string | null
          currency: string | null
          customer_id: string | null
          order_date: string | null
          order_id: number | null
          order_status: string | null
          payment_intent_id: string | null
          payment_status: string | null
        }
      }
      stripe_user_subscriptions: {
        Row: {
          cancel_at_period_end: boolean | null
          current_period_end: number | null
          current_period_start: number | null
          customer_id: string | null
          payment_method_brand: string | null
          payment_method_last4: string | null
          price_id: string | null
          subscription_id: string | null
          subscription_status: string | null
        }
      }
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      stripe_order_status: "pending" | "completed" | "canceled"
      stripe_subscription_status: "not_started" | "incomplete" | "incomplete_expired" | "trialing" | "active" | "past_due" | "canceled" | "unpaid" | "paused"
    }
  }
}