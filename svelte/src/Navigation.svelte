<script>
  import { Link } from "svelte-routing";
</script>

<style>
  nav {
    background-color: #dfe2eb;
    display: flex;
    margin-bottom: 4px;
  }

  nav :global(a) {
    color: #383e4b;
    flex: 1;
    font-weight: 600;
    margin: 0;
    padding: 12px;
    text-align: center;
    transition: background-color ease-out 0.1s, color ease-out 0.1s;
  }

  nav :global(a:hover) {
    background-color: rgba(0, 0, 0, 0.1);
    text-decoration: none;
  }

  nav :global(a[aria-current]) {
    background-color: #2ce698;
    color: #f7f7f7;
  }

  nav :global(a[aria-current]:hover) {
    background-color: #2ce698;
  }
</style>

<nav>
  <Link to="/">Summary</Link>
  <Link to="/securities">Securities</Link>
  <Link to="/positions">Positions</Link>
  <Link to="/forex">Forex</Link>
</nav>
