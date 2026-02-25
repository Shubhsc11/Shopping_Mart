//= require active_admin/base

$(document).ready(function () {
    $('#product_category_id').on('change', function () {
        var categoryId = $(this).val();
        var $subcategorySelect = $('#product_subcategory_id');

        if (!categoryId) {
            $subcategorySelect.empty().append('<option value="">Select Subcategory</option>');
            return;
        }

        $.ajax({
            url: '/subcategories',
            data: { category_id: categoryId },
            dataType: 'json',
            success: function (data) {
                $subcategorySelect.empty().append('<option value="">Select Subcategory</option>');
                $.each(data, function (index, item) {
                    $subcategorySelect.append($('<option>', {
                        value: item.id,
                        text: item.subcategory_name
                    }));
                });
            }
        });
    });
});
