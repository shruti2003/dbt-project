-- macros/check_and_add_column.sql
{% macro check_and_add_column(table_name, column_name, column_definition) %}
    {% set column_exists_query %}
        SELECT COUNT(*) 
        FROM `{{ target.database }}.INFORMATION_SCHEMA.COLUMNS`
        WHERE TABLE_NAME = '{{ table_name }}'
        AND COLUMN_NAME = '{{ column_name }}'
    {% endset %}
    
    {% set result = run_query(column_exists_query) %}
    {% set column_exists = result.rows[0][0] %}
    
    {% if column_exists == 0 %}
        ALTER TABLE {{ target.schema }}.{{ table_name }}
        ADD COLUMN {{ column_name }} {{ column_definition }}
    {% endif %}
{% endmacro %}
