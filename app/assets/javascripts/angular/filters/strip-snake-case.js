angular.module( 'salubrity' )

.filter('stripSnake', function () {
    return function (text) {
        return String(text).replace(/_/g, ' ');
    };
})

;