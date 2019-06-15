<script>
  import Card from "./Card.svelte";

  export let dark = false;
</script>

<style>
  div {
    margin-bottom: 4px;
  }

  div:last-child {
    margin-bottom: 0;
  }
</style>

<div>
  <Card {dark}>
    <slot />
  </Card>
</div>
