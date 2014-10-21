angular.module( 'salubrity' )

.filter('hyphenate', [function () {
    return function (text) {
        return String(text).toLowerCase().replace(/^\s+|\s+$/g, "").replace(/ /g,'-').replace(/[-]+/g, '-').replace(/[^\w-]+/g,'');
    };
}]);