<script>
  export let value;
  export let format = "percent";

  let units = "%";
  let dp = 2;

  let formatter = new Intl.NumberFormat(undefined, {
    minimumFractionDigits: dp,
    maximumFractionDigits: dp
  });

  if (format === "percent") {
    value = value * 100;
  }

  if (format === "notional") {
    value = value / 1000000;
    units = "M";
  }

  value = formatter.format(value);
</script>

<span>{value}{units}</span>
