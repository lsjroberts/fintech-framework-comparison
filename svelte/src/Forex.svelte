<script>
  import { gql } from "apollo-boost";
  import { getClient, query } from "svelte-apollo";

  import Card from "./components/Card.svelte";

  const client = getClient();
  const rates = query(client, {
    query: gql`
      {
        exchangeRates {
          usd
          gbp
          jpy
        }
      }
    `
  });
</script>

<style>
  h2 {
    font-size: 14px;
    line-height: 1;
    margin: 0 0 4px 0;
  }

  span {
    color: #ccc;
    font-size: 28px;
    line-height: 1;
  }

  em {
    color: #ffffff;
    font-weight: 600;
    font-style: normal;
  }

  .error {
    color: #ff0000;
  }
</style>

{#await $rates}
  Loading...
{:then result}
  <!-- {#each result.data.exchangeRates as { label, value }} -->
  <Card>
    <h2>EUR / GBP</h2>
    <span>
      <!-- prettier-ignore -->
       {result.data.exchangeRates.gbp}
    </span>
  </Card>
  <Card>
    <h2>EUR / USD</h2>
    <span>
      <!-- prettier-ignore -->
       {result.data.exchangeRates.usd}
    </span>
  </Card>
  <Card>
    <h2>EUR / JPY</h2>
    <span>
      <!-- prettier-ignore -->
       {result.data.exchangeRates.jpy}
    </span>
  </Card>
  <!-- {/each} -->
{:catch error}
  <div class:error>{error}</div>
{/await}
