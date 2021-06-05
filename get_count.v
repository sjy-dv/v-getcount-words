import os 

fn main() {
	mut path := 'test.txt'
	if os.args.len != 2 {
		println('usage: word_counter [text_file]')
		println('using $path')
	} else {
		path = os.args[1]
	}
	contents := os.read_file(path.trim_space()) or {
		println('failed to open $path')
		return
	}
	mut m := map[string]int{}
	for word in extract_words(contents) {
		m[word]++
	}

	mut keys := m.keys()
	keys.sort()

	for key in keys {
		val := m[key]
		println('$key => $val')
	}
}

fn extract_words(contents string) []string {
	mut splitted := []string{}
	for space_splitted in contents.to_lower().split(' ') {
		if space_splitted.contains('\n') {
			splitted << space_splitted.split('\n')
		} else {
			splitted << space_splitted
		}
	}

	mut results := []string{}
	for s in splitted {
		result := filter_word(s)
		if result == '' {
			continue
		}
		results << result
	}

	return results
}

fn filter_word(word string) string {
	if word == '' || word == ' ' {
		return ''
	}
	mut i := 0
	for i < word.len && !word[i].is_letter() {
		i++
	}
	start := i
	for i < word.len && word[i].is_letter() {
		i++
	}
	end := i
	return word[start..end]
}