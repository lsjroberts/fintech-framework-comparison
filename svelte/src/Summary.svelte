<script>
  import { gql } from "apollo-boost";
  import { getClient, query } from "svelte-apollo";

  import FormatValue from "./components/FormatValue.svelte";
  import Loading from "./components/Loading.svelte";
  import Row from "./components/Row.svelte";

  const client = getClient();
  const summary = query(client, {
    query: gql`
      {
        summary {
          totalAssets
          liquidity {
            percent
          }
          positions {
            percent
          }
          pnl {
            percent
          }
        }
      }
    `
  });
</script>

<style>
  h2 {
    font-size: 28px;
  }

  h3 {
    color: #575c67;
    font-size: 14px;
    margin-bottom: 18px;
  }

  h4 {
    color: #575c67;
    font-size: 14px;
  }

  .value {
    margin-bottom: 4px;
    font-size: 28px;
  }

  .assets li {
    margin-bottom: 18px;
  }

  .assets li:last-child {
    margin-bottom: 0;
  }
</style>

{#await $summary}
  <Loading />
{:then result}
  <Row dark>
    <h2>My Portfolio</h2>
  </Row>

  <Row>
    <h3>Assets</h3>
    <ul class="assets">
      <li>
        <div class="value">
          <FormatValue
            value={result.data.summary.totalAssets}
            format="notional" />
        </div>
        <h4>total assets</h4>
      </li>
      <li>
        <div class="value">
          <FormatValue value={result.data.summary.liquidity.percent} />
        </div>
        <h4>liquidity</h4>
      </li>
      <li>
        <div class="value">
          <FormatValue value={result.data.summary.positions.percent} />
        </div>
        <h4>positions</h4>
      </li>
    </ul>
  </Row>

  <Row>
    <h3>Profit & Loss</h3>
    <div class="value">
      <FormatValue value={result.data.summary.pnl.percent} />
    </div>
    <h4>one day</h4>
  </Row>
{:catch error}
  <div class:error>{error}</div>
{/await}
