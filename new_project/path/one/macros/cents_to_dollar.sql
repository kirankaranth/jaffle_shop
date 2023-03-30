{% macro just_concat() %}
select * from dbt_alice.test limit 1
{% endmacro %}

{% macro cents_to_dollars(column_name, decimal_places=2) %}
round( 1.0 * {{ column_name }} / 100, {{decimal_places}} )
{% endmacro %}
