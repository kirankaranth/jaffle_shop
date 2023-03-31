{% macro just_concat() %}
SELECT *

FROM dbt_alice.test

LIMIT 1

{% endmacro %}

 {% macro cents_to_dollars(column_name, decimal_places = 1) %}
round(1.0 * {{column_name}} / 100, {{decimal_places}})
{% endmacro %}

 