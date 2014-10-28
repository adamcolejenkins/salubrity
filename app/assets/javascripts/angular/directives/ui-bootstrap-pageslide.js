angular.module( 'salubrity' )

.directive('pageslideWindow', ['$pageslideStack', '$timeout', function ($pageslideStack, $timeout, $templateCache) {

    return {
        restrict: "EA",
        scope: {
            index: '@',
            animate: '='
        },
        replace: true,
        transclude: true,
        templateUrl: function (elem, attrs) {
            return attrs.templateUrl || '/templates/partials/pageslideWindow.html';
        },
        link: function (scope, element, attrs) {
            element.addClass(attrs.windowClass || '');
            scope.size = attrs.size;

            $timeout(function () {
                // trigger CSS transitions
                scope.animate = true;
                // focus a freshly opened pageslide
                element[0].focus();
            });

            scope.close = function (evt) {
                var pageslide = $pageslideStack.getTop();
                if (pageslide && pageslide.value.backdrop && pageslide.value.backdrop != 'static' && (evt.target === evt.currentTarget)) {
                    evt.preventDefault();
                    evt.stopPropagation();
                    $pageslideStack.dismiss(pageslide.key, 'backdrop click');
                }
            };
        }
    };
}]) // end app.directive('pageslideWindow')

.factory('$pageslideStack', ['$transition', '$timeout', '$document', '$compile', '$rootScope', '$$stackedMap', function ($transition, $timeout, $document, $compile, $rootScope, $$stackedMap) {

    var OPENED_PAGESLIDE_CLASS = 'pageslide-open';

    var backdropDomEl, backdropScope;
    var openedWindows = $$stackedMap.createNew();
    var $pageslideStack = {};

    function backdropIndex() {
        var topBackdropIndex = -1;
        var opened = openedWindows.keys();
        for (var i = 0; i < opened.length; i++) {
            if (openedWindows.get(opened[i]).value.backdrop) {
                topBackdropIndex = i;
            }
        }
        return topBackdropIndex;
    }

    $rootScope.$watch(backdropIndex, function (newBackdropIndex) {
        if(backdropScope) {
            backdropScope.index = newBackdropIndex;
        }
    });

    function removePageslideWindow(pageslideInstance) {
        var body = $document.find('body').eq(0);
        var pageslideWindow = openedWindows.get(pageslideInstance).value;

        // clean up the stack
        openedWindows.remove(pageslideInstance);

        // remove window DOM element
        removeAfterAnimate(pageslideWindow.pageslideDomEl, pageslideWindow.pageslideScope, 300, function () {
            pageslideWindow.pageslideScope.$destroy();
            body.toggleClass(OPENED_PAGESLIDE_CLASS, openedWindows.length() > 0);
            checkRemoveBackdrop();
        });
    }
    
    function checkRemoveBackdrop() {
        // remove backdrop if no longer needed
        if (backdropDomEl && backdropIndex() == -1) {
            var backdropScopeRef = backdropScope;
            removeAfterAnimate(backdropDomEl, backdropScope, 150, function () {
                backdropScopeRef.$destroy();
                backdropScopeRef = null;
            });
            backdropDomEl = undefined;
            backdropScope = undefined;
        }
    }

    function removeAfterAnimate(domEl, scope, emulateTime, done) {
        // closing animation
        scope.animate = false;

        var transitionEndEventName = $transition.transitionEndEventName;
        if (transitionEndEventName) {
            // transition out
            var timeout = $timeout(afterAnimating, emulateTime);

            domEl.bind(transitionEndEventName, function () {
                $timeout.cancel(timeout);
                afterAnimating();
                scope.$apply();
            });
        } else {
            // Ensure this call is async
            $timeout(afterAnimating, 0);
        }

        function afterAnimating() {
            if (afterAnimating.done) {
                return;
            }
            afterAnimating.done = true;

            domEl.remove();
            if (done) {
                done();
            }
        }
    }

    $document.bind('keydown', function (evt) {
        var pageslide;
        if (evt.which === 27) {
            pageslide = openedWindows.top();
            if (pageslide && pageslide.value.keyboard) {
                evt.preventDefault();
                $rootScope.$apply(function () {
                    $pageslideStack.dismiss(pageslide.key, 'escape key press');
                });
            }
        }
    });

    $pageslideStack.open = function (pageslideInstance, pageslide) {

        openedWindows.add(pageslideInstance, {
            deferred: pageslide.deferred,
            pageslideScope: pageslide.scope,
            backdrop: pageslide.backdrop,
            keyboard: pageslide.keyboard
        });

        var body = $document.find('body').eq(0),
            currBackdropIndex = backdropIndex();

        if (currBackdropIndex >= 0 && !backdropDomEl) {
            backdropScope = $rootScope.$new(true);
            backdropScope.index = currBackdropIndex;
            backdropDomEl = $compile('<div modal-backdrop></div>')(backdropScope);
            body.append(backdropDomEl);
        }

        var angularDomEl = angular.element('<div pageslide-window></div>');
        angularDomEl.attr({
            'template-url': pageslide.windowTemplateUrl,
            'window-class' : pageslide.windowClass,
            'size': pageslide.size,
            'index': openedWindows.length() - 1,
            'animate': 'animate'
        }).html(pageslide.content);

        var pageslideDomEl = $compile(angularDomEl)(pageslide.scope);
        openedWindows.top().value.pageslideDomEl = pageslideDomEl;
        body.append(pageslideDomEl);
        body.addClass(OPENED_PAGESLIDE_CLASS);

    };

    $pageslideStack.close = function (pageslideInstance, result) {
        var pageslideWindow = openedWindows.get(pageslideInstance).value;
        if (pageslideWindow) {
            pageslideWindow.deferred.resolve(result);
            removePageslideWindow(pageslideInstance);
        }
    };

    $pageslideStack.dismiss = function (pageslideInstance, reason) {
        var pageslideWindow = openedWindows.get(pageslideInstance).value;
        if (pageslideWindow) {
            pageslideWindow.deferred.resolve(reason);
            removePageslideWindow(pageslideInstance);
        }
    };

    $pageslideStack.dismissAll = function (reason) {
        var topPageslide = this.getTop();
        while (topPageslide) {
            this.dismiss(topPageslide.key, reason);
            topPageslide = this.getTop();
        }
    };

    $pageslideStack.getTop = function () {
        return openedWindows.top();
    };

    return $pageslideStack;
}

]) // end app.factory('$pageslideStack')

.provider('$pageslide', function () {

    var $pageslideProvider = {
        options: {
            backdrop: false,
            keyboard: true
        },
        $get: ['$injector', '$rootScope', '$q', '$http', '$templateCache', '$controller', '$pageslideStack', function ($injector, $rootScope, $q, $http, $templateCache, $controller, $pageslideStack) {

            var $pageslide = {};

            function getTemplatePromise(options) {
                return options.template ? $q.when(options.template) : $http.get(options.templateUrl, {cache: $templateCache}).then(function (result) {
                    return result.data;
                });
            }

            function getResolvePromises(resolves) {
                var promisesArr = [];
                angular.forEach(resolves, function (value, key) {
                    if (angular.isFunction(value) || angular.isArray(value)) {
                        promisesArr.push($q.when($injector.invoke(value)));
                    }
                });
                return promisesArr;
            }

            $pageslide.open = function (pageslideOptions) {

                var pageslideResultDeferred = $q.defer();
                var pageslideOpenedDeferred = $q.defer();

                // prepare an instance of the pageslide to be injected into controllers
                // and returned to a caller
                var pageslideInstance = {
                    result: pageslideResultDeferred.promise,
                    opened: pageslideOpenedDeferred.promise,
                    close: function (result) {
                        $pageslideStack.close(pageslideInstance, result);
                    },
                    dismiss: function (reason) {
                        $pageslideStack.dismiss(pageslideInstance, reason);
                    }
                };

                // merge and clean up options
                pageslideOptions = angular.extend({}, $pageslideProvider.options, pageslideOptions);
                pageslideOptions.resolve = pageslideOptions.resolve || {};

                // verify options
                if (!pageslideOptions.template && !pageslideOptions.templateUrl) {
                    throw new Error('One of template or templateUrl options is required.');
                }

                var templateAndResolvePromise = $q.all([getTemplatePromise(pageslideOptions)].concat(getResolvePromises(pageslideOptions.resolve)));

                templateAndResolvePromise.then(function resolveSuccess(tplAndVars) {

                    var pageslideScope = (pageslideOptions.scope || $rootScope).$new();
                    pageslideScope.$close = pageslideOptions.close;
                    pageslideScope.$dismiss = pageslideOptions.dismiss;

                    var ctrlInstance, ctrlLocals = {};
                    var resolveIter = 1;

                    // controllers
                    if (pageslideOptions.controller) {
                        ctrlLocals.$scope = pageslideScope;
                        ctrlLocals.$pageslideInstance = pageslideInstance;
                        angular.forEach(pageslideOptions.resolve, function (value, key) {
                            ctrlLocals[key] = tplAndVars[resolveIter++];
                        });

                        ctrlInstance = $controller(pageslideOptions.controller, ctrlLocals);
                    }

                    $pageslideStack.open(pageslideInstance, {
                        scope: pageslideScope,
                        deferred: pageslideResultDeferred,
                        content: tplAndVars[0],
                        backdrop: pageslideOptions.backdrop,
                        keyboard: pageslideOptions.keyboard,
                        windowClass: pageslideOptions.windowClass,
                        windowTemplateUrl: pageslideOptions.windowTemplateUrl,
                        size: pageslideOptions.size
                    });

                }, function resolveError(reason) {
                    pageslideResultDeferred.reject(reason);
                });

                templateAndResolvePromise.then(function () {
                    pageslideOpenedDeferred.resolve(true);
                }, function () {
                    pageslideOpenedDeferred.reject(false);
                });

                return pageslideInstance;

            };

            return $pageslide;
        }]
    };

    return $pageslideProvider;

}) // end app.provider('$pageslide')

.controller('PageslideInstanceCtrl', function ($scope, $pageslideInstance, data) {
    $scope.data = data;

    $scope.proceed = function () {
        $pageslideInstance.close(data);
    };

    $scope.cancel = function () {
        $pageslideInstance.dismiss('cancel');
    };
})

;