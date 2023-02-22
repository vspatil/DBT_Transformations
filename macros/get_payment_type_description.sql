{#
    This macro returns the description of the payment_type
#}

{% macro get_payment_type_description(payment_type) %}

    case {{ payment_type }}
        when 1 then 'credit card'
        when 2 then 'cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'unknown'
        when 6 then 'voided tip'
    end
    
{% endmacro %}