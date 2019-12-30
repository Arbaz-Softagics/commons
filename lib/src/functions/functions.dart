
delay(Duration duration, Function fun) {
	Future.delayed(duration, () {
		fun();
	});
}
