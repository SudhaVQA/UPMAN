package features.gitApp;

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testTask1() {
        return Karate.run("task1_API").relativeTo(getClass());
    }
    @Karate.Test
    Karate testTask2() {
        return Karate.run("task2_UI").relativeTo(getClass());
    }

}
