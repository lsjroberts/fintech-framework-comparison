<script>
  export let dark = false;
</script>

<style>
  div {
    background-color: #dfe2eb;
    color: #383e4b;
    padding: 28px;
  }

  .dark {
    background-color: #383e4b;
    color: #ffffff;
  }
</style>

<div class:dark>
  <slot />
</div>
