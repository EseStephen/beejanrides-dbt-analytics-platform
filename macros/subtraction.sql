{% macro subtract(x, y, precision) %}
    round({{ x }} - {{ y }}, {{ precision }})
{% endmacro %}