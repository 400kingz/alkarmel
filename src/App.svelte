<script lang="ts">
  import { Router, Route } from "svelte-routing";
  import Header from "./components/Header.svelte";
  import Footer from "./components/Footer.svelte";
  import Home from "./routes/Home.svelte";
  import Products from "./routes/Products.svelte";
  import About from "./routes/About.svelte";
  import Contact from "./routes/Contact.svelte";
  import Gallery from "./routes/Gallery.svelte";
  import Admin from "./routes/Admin.svelte";
  import Login from "./routes/Login.svelte";
  import Profile from "./routes/Profile.svelte";
  import Checkout from "./routes/Checkout.svelte";

  export let url = "";
</script>

<Router {url}>
  <div class="flex flex-col min-h-screen">
    <Header />
    <main class="flex-grow">
      <Route path="/" component={Home} />
      <Route path="/products" component={Products} />
      <Route path="/about" component={About} />
      <Route path="/contact" component={Contact} />
      <Route path="/gallery" component={Gallery} />
      <Route path="/admin" component={Admin} />
      <Route path="/login" component={Login} />
      <Route path="/profile" component={Profile} />
      <Route path="/checkout" component={Checkout} />
    </main>
    <Footer />
  </div>
</Router>