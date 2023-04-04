{{
    config(
        tags=['unit-test'],
        now='2022-12-13'
    )
}}

{% call test_model('customer_counts_daily', '', {"output_sort_field": "period"}) %}
  {% call mock_source_csv('acme', 'customers') %}
  id,first_name,last_name,created_at::timestamp,deleted_at::timestamp
  '123', 'first', 'last', '2022-12-01', {{"null"}}
  '234', 'another', 'customer', '2022-12-07', {{"null"}}
  '345', 'deleted', 'customer', '2022-12-09', '2022-12-10'
  {% endcall %}

  {% call expect_csv() %}
  period::timestamp, total
  '2022-12-01',1
  '2022-12-02',1
  '2022-12-03',1
  '2022-12-04',1
  '2022-12-05',1
  '2022-12-06',1
  '2022-12-07',2
  '2022-12-08',2
  '2022-12-09',3
  '2022-12-10',3
  '2022-12-11',3
  '2022-12-12',3
  '2022-12-13',3
  {% endcall %}
{% endcall %}
