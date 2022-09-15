<?php

class Example
{
    public function __construct(
        protected readonly string $foobar
    ) {
    }

    public function fuckide(): int
    {
        return $this->foobar;
    }
}
