# Git Upload Guide for Daily Practice

## Overview
This guide explains how to upload your daily learning evidence to GitHub for Cognizant Assessment tracking.

---

## Step 1: Setup Your Git Repository

### If you don't have a GitHub account:
1. Go to https://github.com/signup
2. Create free account
3. Create new repository named: `CTS_Deep_Skilling`
4. Add description: "Cognizant Deep Skilling - Module 1 & 2 Practice"

### Clone the repository locally:
```bash
git clone https://github.com/YOUR_USERNAME/CTS_Deep_Skilling.git
cd CTS_Deep_Skilling
```

---

## Step 2: Daily Upload Structure

```
CTS_Deep_Skilling/
├── README.md                          # Main overview
├── PROGRESS_TRACKER.md               # This file
├── Module_1_DesignPatterns/
│   ├── Day2_Learning.md             # Daily learning notes
│   ├── Day3_Learning.md
│   ├── Exercise1_Singleton/
│   │   ├── Logger.java
│   │   ├── SingletonTest.java
│   │   └── OUTPUT.txt               # Execution output
│   ├── Exercise2_Factory/
│   │   ├── Document.java
│   │   ├── DocumentFactory.java
│   │   └── OUTPUT.txt
│   ├── Exercise3_Builder/
│   │   ├── Person.java
│   │   ├── BuilderPatternTest.java
│   │   └── OUTPUT.txt
│   └── Exercise4_Composite/
│       ├── FileSystemComponent.java
│       ├── Folder.java
│       ├── File.java
│       ├── CompositePatternTest.java
│       └── OUTPUT.txt
└── Module_2_DSA/
    ├── (To be added)
```

---

## Step 3: Daily Upload Workflow

### After completing exercises for the day:

#### 1. Create Daily Learning Notes
Create a file: `Day#_Learning.md` in the module folder

**Template:**
```markdown
# Day X Learning Log

**Date**: YYYY-MM-DD
**Module**: Module Name
**Status**: What you completed

## Topics Covered
- Topic 1
- Topic 2

## Key Learnings
[Your insights]

## Exercises Completed
- [x] Exercise name

## Code Examples
[Code snippets if needed]

## Challenges Encountered
[Any blockers and solutions]

## Resources Used
[Links to documentation]

## Tomorrow's Plan
[What's next]
```

#### 2. Run Your Tests and Capture Output
```bash
# Compile Java files
javac Exercise1_Singleton/*.java

# Run test and save output
java singletonpattern.SingletonTest > Exercise1_Singleton/OUTPUT.txt

# Verify output file
cat Exercise1_Singleton/OUTPUT.txt
```

#### 3. Stage Your Changes
```bash
# Add all changes
git add .

# Or add specific files
git add Module_1_DesignPatterns/Day2_Learning.md
git add Module_1_DesignPatterns/Exercise1_Singleton/
```

#### 4. Commit with Descriptive Message
```bash
git commit -m "feat: Module 1 Exercise 1 & 2 + Day 2 Learning (Singleton & Factory Patterns)

- Implemented Singleton Pattern (Logger class)
- Implemented Factory Method Pattern (Document types)
- Fixed package naming conventions
- Added comprehensive test cases
- Daily learning notes: Day2_Learning.md

Evidence:
- Exercise 1: Logger.java, SingletonTest.java (tested ✓)
- Exercise 2: Document.java, *Factory.java (tested ✓)
- Resources used: SOLID principles + design pattern documentation
"
```

#### 5. Push to GitHub
```bash
git push origin main
```

---

## Step 4: Daily Commit Checklist

Before pushing, verify:

- [ ] All Java files compile without errors
- [ ] Test classes run successfully
- [ ] Output captured in OUTPUT.txt files
- [ ] Daily learning notes created (Day#_Learning.md)
- [ ] README files in each exercise folder
- [ ] Progress tracker updated
- [ ] Meaningful commit message
- [ ] All files added and committed
- [ ] Pushed to GitHub

---

## Step 5: Recommended Daily Schedule

```
📅 DAILY PRACTICE SCHEDULE (Catch-up Week)

MORNING (9:00 - 12:00)
├── Review previous learning
├── Study new concepts
└── Implement exercise code

AFTERNOON (12:00 - 16:00)
├── Test implementations
├── Debug issues
└── Create daily notes

EVENING (16:00 - 17:00)
├── Prepare output files
├── Update progress tracker
├── Create Git commit
└── Push to GitHub ✓

REFLECTION (17:00 - 17:30)
├── Document challenges
├── Plan next day
└── Self-assessment
```

---

## Example Commits for Next 3 Days

### Day 2 (Already Done)
```bash
git commit -m "docs: Day 2 Learning - SOLID Principles Deep Dive

Completed:
- Studied all 5 SOLID principles with examples
- Reviewed Exercise 1 & 2 implementations
- Fixed package naming from CamelCase to lowercase

Evidence:
- Day2_Learning.md: SOLID principles breakdown
- Code review: Singleton + Factory patterns
"
```

### Day 3 (Tomorrow - Saturday)
```bash
git commit -m "feat: Exercise 3 & 4 - Builder & Composite Patterns

Completed Exercises:
✓ Exercise 3: Builder Pattern (Person builder)
  - Person.java with fluent API
  - BuilderPatternTest.java with 4 test cases
  - Validation for required fields

✓ Exercise 4: Composite Pattern (File system)
  - FileSystemComponent.java (interface)
  - File.java (leaf component)
  - Folder.java (composite component)
  - CompositePatternTest.java with hierarchy demo

Evidence:
- Test output: All tests pass
- Daily notes: Day3_Learning.md
- Learning outcomes documented

Status: Module 1 - 90% Complete
Next: Module 1 Review & Quiz
"
```

### Day 4 (Monday)
```bash
git commit -m "feat: Module 1 Complete - Review & Quiz Preparation

Completed:
✓ All 4 Mandatory Exercises tested
✓ Module 1 comprehensive review
✓ Design Patterns summary

Evidence:
- Day4_Learning.md: Module 1 review notes
- PROGRESS_TRACKER.md: Updated
- All 4 exercises with OUTPUT.txt files
- Quiz preparation materials

Status: Ready for Module 2 - Data Structures & Algorithms
"
```

---

## Verification Checklist

### Before Final Push:
```bash
# Check git status
git status

# View staged changes
git diff --cached

# Check commit log
git log --oneline -5

# Verify files exist
ls -R Module_1_DesignPatterns/
```

### Expected Output:
```
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```

---

## Troubleshooting

### Issue: "fatal: not a git repository"
**Solution:**
```bash
git init
git remote add origin https://github.com/YOUR_USERNAME/CTS_Deep_Skilling.git
```

### Issue: "permission denied" during push
**Solution:**
```bash
# Generate SSH key if not already done
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to GitHub: Settings > SSH and GPG keys > New SSH key
```

### Issue: Merge conflicts
**Solution:**
```bash
git pull origin main
# Resolve conflicts in editor
git add .
git commit -m "fix: Merge conflicts resolved"
git push origin main
```

---

## Weekly Summary Example

After each week, create a summary:

```markdown
# Week of June 16-22 - Catch-Up Summary

## Completed
- ✅ Module 1: Design Patterns (90% progress)
- ✅ 4 Mandatory exercises completed
- ✅ 3 daily learning notes
- ✅ 15 commits to GitHub

## Next Week
- [ ] Complete Module 2 exercises
- [ ] Take final assessment
- [ ] Prepare presentation

## Metrics
- Code Quality: 8.5/10
- Documentation: 9/10
- Timeliness: 9/10
- Overall: 8.8/10
```

---

## Important Notes

1. **Daily Uploads**: Push at least once per day for evidence trail
2. **Code Comments**: Add comments explaining your logic
3. **Output Capture**: Always save test execution output
4. **Meaningful Commits**: Use descriptive messages
5. **README Files**: Keep documentation up to date
6. **Progress Tracker**: Update daily

---

## Resources

- [Git Tutorial](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Commit Message Best Practices](https://chris.beams.io/posts/git-commit/)

---

**Last Updated**: 2026-06-17  
**Next Review**: Daily
