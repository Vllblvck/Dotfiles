import random
import argparse


def get_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument('-t', '--text', type=str, required=True)
    parser.add_argument('-v', '--variants', type=int, required=False,
                        default=1, help='Number of different variants of mock')

    return vars(parser.parse_args())


def mock(text):
    chars = list(text)

    for i, c in enumerate(chars):
        if random.random() < 0.5:
            chars[i] = c.upper()
        else:
            chars[i] = c.lower()

    return ''.join(chars)


def main():
    args = get_arguments()
    for x in range(0, args['variants']):
        print(mock(args['text']))


if __name__ == '__main__':
    main()
