package main

import "core:fmt"

main :: proc() {
	co := Checkout{"DABABA"} // Test value.

	items := scan(co.order) // Gathers the frequency of the orders.

	price := total_of_goods(items)
	fmt.println(price)
	// Calculates the price of the values and shows it to the user.
}
