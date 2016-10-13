# Write a function to generate all permuations of a string.


import unittest


# will there be duplicates?


def gen_perms(s):

    if len(s) == 0:
        return set()

    if len(s) == 1:
        return {s}

    return gen_perms_helper(s)


def gen_perms_helper(s):

    perms = set()

    for p in gen_perms(s[0:-1]):
        for i in range(len(s)):
            new_perm = p[:i] + s[-1] + p[i:]
            perms.add(new_perm)

    return perms


# def gen_perms_helper2(s):




# Test Cases
# - A test case is a tuple:
#    (input, expected output)

class MyTest(unittest.TestCase):
    def test_all(self):

        test_cases = [
            ('',  set()),
            ('a', {'a'}),
            ('ab', {'ab', 'ba'}),
            ('xyz', {'xyz', 'xzy',
                     'yxz', 'yzx',
                     'zxy', 'zyx' }),

        ]

        for input, expected_output in test_cases:
            self.assertEqual(gen_perms(input), expected_output)


if __name__ == '__main__':
    unittest.main()




