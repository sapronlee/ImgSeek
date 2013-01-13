(function($) {
	$.fn.select_all = function() {
		return this.each(function() {
			var obj = $(this);
			var checked = false;
			var item = obj.parents("table").find("input[name*='_ids']:checkbox");
			obj.click(function() {
				if(!checked) {
					item.attr("checked", !checked);
				} else {
					item.removeAttr("checked");
				}
				checked = !checked;
			});
		});
	};
})(jQuery);