<script>
  import ApolloClient from "apollo-boost";
  import { setClient } from "svelte-apollo";
  import { Router, Route } from "svelte-routing";

  import Loading from "./components/Loading.svelte";
  import Forex from "./Forex.svelte";
  import Header from "./Header.svelte";
  import Navigation from "./Navigation.svelte";
  import Summary from "./Summary.svelte";

  export let url = "";

  const client = new ApolloClient({ uri: "http://localhost:4000/api" });
  setClient(client);
</script>

<style>
  .app {
    background-image: radial-gradient(circle at 30px 30px, #ffffff, #f7f7f7);
    display: flex;
    flex-direction: column;
    height: 100%;
  }
</style>

<div class="app">
  <Router {url}>
    <Header />
    <Navigation />
    <Route component={Summary} />
    <Route path="securities" component={Loading} />
    <Route path="positions" component={Loading} />
    <Route path="forex" component={Forex} />
  </Router>
</div>
