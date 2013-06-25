package com.sampleapp;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class SampleAppTest {
    @Test
    public void shouldReturnSampleApp() {
        Assert.assertEquals(new SampleApp().text(), "sample app");
    }

}
