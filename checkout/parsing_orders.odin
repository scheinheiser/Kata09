package main

import "core:fmt"

SPACE :: ' '
COMMA :: ','

Checkout :: struct {
	order : string,
}

prices := map[rune][2]int{
				'A'={50, 130},
				'B'={30, 45},
				'C'={20, 0},
				'D'={15, 0}
}
// Put in global space so it can be used in both functions.

scan :: proc(order_items: string) -> (item_frequency: map[rune]int) {
	for item in order_items {
		if item == SPACE || item == COMMA || !(item in prices){
			continue
		}
		// Ignores spaces/commas/invalid items to ensure that only the valid items are counted.

		key_existence := item in item_frequency // Returns a bool that indicates if the item has already been counted.

		if key_existence {
			item_frequency[item] += 1
		} else {
			item_frequency[item] = 1
		}
		// Adds to the frequency if it exists, or initialises the item key with a value of one if it doesn't.
	}

	return item_frequency
}

total_of_goods :: proc(item_frequency : map[rune]int) -> (total_price : int) {
	discount_condition := map[rune]int{
				'A'=3,
				'B'=2,
	}

	number_of_normals : int = 0
	// Defines it outside of the for loop so the compiler isn't mad.

	for item in item_frequency {
		if item == 'A' && item_frequency['A'] >= discount_condition['A'] {
			number_of_discounts : int = item_frequency[item] / discount_condition['A']
			// Gets the number of available discounts through the amount of items divided by the discount condition.
			// In this case, it's 3 for 130p.

			if item_frequency[item] == discount_condition['A'] {number_of_normals = 0}
			else {number_of_normals = item_frequency[item] - (number_of_discounts * discount_condition['A'])}
			// If the number of items is equal to the discount condition, this means that there is no normally-priced item.
			// If not, the number of normally-priced items will be equal to the number of discounted items subtracted from the total.

			total_price += (number_of_discounts * prices['A'][1]) + (number_of_normals * prices['A'][0])
			// This adds the price of the discounted items and normal items to the total price.

			continue
		}
		else if item == 'B' && item_frequency['B'] >= discount_condition['B'] {
			number_of_discounts : int = item_frequency[item] / discount_condition['B']
			// Gets the number of available discounts through the amount of items divided by the discount condition.
			// In this case, it's 2 for 45p.

			if item_frequency[item] == discount_condition['B'] {number_of_normals = 0}
			else {number_of_normals = item_frequency[item] - (number_of_discounts * discount_condition['B'])}
			// Functions the same as in the A branch.

			total_price += (number_of_discounts * prices['B'][1]) + (number_of_normals * prices['B'][0])
			// Adds the price of all B items to the total price.

			continue
		}
		else {
			total_price += prices[item][0] * item_frequency[item]
			// If it's C, D or an amount of A/B that doesn't meet the initial condition, it multiplies the number of items by the price
			// to get the total price of the items. This is then added to the total.

			continue
		}
	}

	return total_price
}
