<script>
  import ApolloClient from "apollo-boost";
  import { setClient } from "svelte-apollo";
  import { Router, Route } from "svelte-routing";

  import Forex from "./Forex.svelte";
  import Header from "./Header.svelte";
  import Navigation from "./Navigation.svelte";

  export let url = "";

  const client = new ApolloClient({ uri: "http://localhost:4000/api" });
  setClient(client);
</script>

<style>
  .app {
    background-image: radial-gradient(circle at 30px 30px, #ffffff, #f7f7f7);
    height: 100%;
  }
</style>

<div class="app">
  <Router {url}>
    <Header />
    <Navigation />
    <Route path="forex" component={Forex} />
  </Router>
</div>
